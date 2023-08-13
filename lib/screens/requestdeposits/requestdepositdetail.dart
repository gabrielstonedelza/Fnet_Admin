import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';

class BankDepositRequestDetail extends StatefulWidget {
  final date_requested;
  const BankDepositRequestDetail({super.key,required this.date_requested});

  @override
  State<BankDepositRequestDetail> createState() => _BankDepositRequestDetailState(date_requested:this.date_requested);
}

class _BankDepositRequestDetailState extends State<BankDepositRequestDetail> {
  final date_requested;
  _BankDepositRequestDetailState({required this.date_requested});
  var items;
  late List allRequests = [];
  late List allRequestsDates = [];
  bool isLoading = true;
  double sum = 0.0;

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
        if(i['date_requested'] == date_requested){
          allRequestsDates.add(i);
          sum = sum + double.parse(i['amount']);
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
        title: Text("Requests for $date_requested"),
      ),
      body: isLoading
          ? const LoadingUi()
          : ListView.builder(
          itemCount:
          allRequestsDates != null ? allRequestsDates.length : 0,
          itemBuilder: (context, index) {
            items = allRequestsDates[index];
            return Card(
              color: secondaryColor,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: RowWidget(items: items, title: 'Agent: ', itemTitle: 'agent_username',),
                subtitle: Column(
                  children: [
                    RowWidget(items: items, title: 'Customer: ', itemTitle: 'customer',),
                    RowWidget(items: items, title: 'Bank: ', itemTitle: 'bank',),
                    RowWidget(items: items, title: 'Acc No: ', itemTitle: 'account_number',),
                    RowWidget(items: items, title: 'Acc Name: ', itemTitle: 'account_name',),
                    RowWidget(items: items, title: 'Amount: ', itemTitle: 'amount',),
                    RowWidget(items: items, title: 'Req Status: ', itemTitle: 'request_status',),
                    RowWidget(items: items, title: 'Req Paid: ', itemTitle: 'deposit_paid',),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("Date: ",style: TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(items['date_requested'],style: const TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("Time: ",style: TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(items['time_requested'].toString().split(".").first,style: const TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: (){
          Get.defaultDialog(
            buttonColor: primaryColor,
            title: "Total",
            middleText: "$sum",
            confirm: RawMaterialButton(
                shape: const StadiumBorder(),
                fillColor: primaryColor,
                onPressed: (){
                  Get.back();
                }, child: const Text("Close",style: TextStyle(color: Colors.white),)),
          );
        },
        child: const Text("Total"),
      ),
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
