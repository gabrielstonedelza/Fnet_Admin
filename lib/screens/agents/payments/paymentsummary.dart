import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/agents/payments/paymentsummarydetail.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../static/app_colors.dart';
import '../../../widgets/loadingui.dart';




class PaymentSummary extends StatefulWidget {
  final username;
  const PaymentSummary({Key? key,required this.username}) : super(key: key);

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState(username:this.username);
}

class _PaymentSummaryState extends State<PaymentSummary> {
  final username;
  _PaymentSummaryState({required this.username});
  double sum = 0.0;
  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late List allPayments = [];
  var items;
  bool isLoading = true;
  late List amounts = [];
  late List paymentsAmounts = [];
  late List paymentDates = [];

  Future<void>fetchAllPaymentRequests()async{
    final url = "https://fnetghana.xyz/user_transaction_payments/$username/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      // "Authorization": "Token $uToken"
    });

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allPayments = json.decode(jsonData);

      for(var i in allPayments){
        if(!paymentDates.contains(i['date_created'].toString().split("T").first)){
          paymentDates.add(i['date_created'].toString().split("T").first);
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
    fetchAllPaymentRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$username's Payment Summary"),

      ),
      body: isLoading ? const LoadingUi() :
      ListView.builder(
          itemCount: paymentDates != null ? paymentDates.length : 0,
          itemBuilder: (context,i){
            items = paymentDates[i];
            return Column(
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return PaymentSummaryDetail(date_created:paymentDates[i],username:username);
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

    );
  }
}
