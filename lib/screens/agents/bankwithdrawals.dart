import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';
import 'banks/bankwithdrawalsummarydetail.dart';




class BankWithdrawalSummary extends StatefulWidget {
  final username;
  const BankWithdrawalSummary({Key? key,required this.username}) : super(key: key);

  @override
  State<BankWithdrawalSummary> createState() => _BankWithdrawalSummaryState(username:this.username);
}

class _BankWithdrawalSummaryState extends State<BankWithdrawalSummary> {
  final username;
  _BankWithdrawalSummaryState({required this.username});
  double sum = 0.0;
  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late List allBankWithdrawals = [];
  var items;
  bool isLoading = true;
  late List amounts = [];
  late List bankAmounts = [];
  late List bankWithdrawalDates = [];

  Future<void>fetchAllAgentsBankWithdrawals()async{
    final url = "https://fnetghana.xyz/user_transaction_withdrawals/$username/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      // "Authorization": "Token $uToken"
    });

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allBankWithdrawals = json.decode(jsonData);
      print(allBankWithdrawals);

      for(var i in allBankWithdrawals){
        if(!bankWithdrawalDates.contains(i['date_requested'].toString().split("T").first)){
          bankWithdrawalDates.add(i['date_requested'].toString().split("T").first);
        }
      }
    }

    setState(() {
      isLoading = false;
    });
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
    fetchAllAgentsBankWithdrawals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("$username's Bank Withdrawal Summary"),

      ),
      body: isLoading ? const LoadingUi() :
      ListView.builder(
          itemCount: bankWithdrawalDates != null ? bankWithdrawalDates.length : 0,
          itemBuilder: (context,i){
            items = bankWithdrawalDates[i];
            return Column(
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return BankWithdrawalSummaryDetail(date_requested:bankWithdrawalDates[i],username: username,);
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
      //     Get.to(() => const BankWithdrawal());
      //   },
      // )
    );
  }
}
