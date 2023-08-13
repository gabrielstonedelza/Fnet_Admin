import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fnet_admin/screens/requestdeposits/requestdepositdetail.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../static/app_colors.dart';

class AllDepositRequests extends StatefulWidget {
  const AllDepositRequests({super.key});

  @override
  State<AllDepositRequests> createState() => _AllDepositRequestsState();
}

class _AllDepositRequestsState extends State<AllDepositRequests> {
  // final RequestController requestController = Get.find();
  var items;
  late List allRequests = [];
  late List allRequestsDates = [];
  bool isLoading = true;

  Future<void> getAllDeposits() async {
    const profileLink = "https://fnetghana.xyz/admin_get_all_bank_deposits/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    });

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      allRequests.assignAll(jsonData);
      for(var i in allRequests){
        if(!allRequestsDates.contains(i['date_requested'])){
          allRequestsDates.add(i['date_requested']);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
    }
  }
  // late Timer _timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDeposits();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Requests"),
      ),
      body: isLoading ? const LoadingUi() : ListView.builder(
          itemCount: allRequestsDates != null ? allRequestsDates.length : 0,
          itemBuilder: (context,index){
            items = allRequestsDates[index];
            return Card(
              color: secondaryColor,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                onTap: (){
                  Get.to(() => BankDepositRequestDetail(date_requested:allRequestsDates[index]));
                },
                title: Text(items,style: const TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
              ),
            );
          })
    );
  }
}

class RowWidget extends StatelessWidget {
  String title;
  String itemTitle;
  RowWidget({
    super.key,
    required this.items,
    required this.title,
    required this.itemTitle
  });

  final  items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(title,style: const TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0,bottom: 8),
          child: Text(items[itemTitle],style: const TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
        ),
      ],
    );
  }
}
