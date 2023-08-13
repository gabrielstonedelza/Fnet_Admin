import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/agents/reports/reportsummarydetail.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../static/app_colors.dart';
import '../../../widgets/loadingui.dart';



class ReportSummary extends StatefulWidget {
  final username;
  const ReportSummary({Key? key,required this.username}) : super(key: key);

  @override
  State<ReportSummary> createState() => _ReportSummaryState(username:this.username);
}

class _ReportSummaryState extends State<ReportSummary> {
  final username;
  _ReportSummaryState({required this.username});
  double sum = 0.0;
  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late List allReports = [];
  var items;
  bool isLoading = true;
  late List reports = [];
  late List reportDates = [];

  Future<void>fetchAllAgentsReports()async{
    final url = "https://fnetghana.xyz/get_user_reports/$username";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Authorization": "Token $uToken"
    });

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allReports = json.decode(jsonData);
      for(var i in allReports){
        if(!reportDates.contains(i['date_reported'].toString().split("T").first)){
          reportDates.add(i['date_reported'].toString().split("T").first);
        }
      }
      setState(() {
        isLoading = false;
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(storage.read("token") != null){
      setState(() {
        uToken = storage.read("token");
      });
    }
    fetchAllAgentsReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Summary"),
      ),
      body: isLoading ? const LoadingUi() :
      ListView.builder(
          itemCount: reportDates != null ? reportDates.length : 0,
          itemBuilder: (context,i){
            items = reportDates[i];
            return Column(
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ReportSummaryDetail(date_reported:reportDates[i],username:username);
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Card(
                      color: secondaryColor,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      // shadowColor: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                const Text("Date: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                Text(items,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
      ),
      // floatingActionButton:FloatingActionButton(
      //   backgroundColor: secondaryColor,
      //   child: const Icon(Icons.add,size: 30,),
      //   onPressed: (){
      //     Get.to(() => const BankDeposit());
      //   },
      // )
    );
  }
}
