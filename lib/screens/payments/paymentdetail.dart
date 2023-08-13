import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';

class PaymentDetail extends StatefulWidget {
  final date_created;
  const PaymentDetail({super.key,required this.date_created});

  @override
  State<PaymentDetail> createState() => _PaymentDetailState(date_created:this.date_created);
}

class _PaymentDetailState extends State<PaymentDetail> {
  final date_created;
  _PaymentDetailState({required this.date_created});
  var items;
  late List allPayments = [];
  late List allPaymentDates = [];
  bool isLoading = true;
  double sum = 0.0;

  Future<void> getAllPayments() async {
    const profileLink = "https://fnetghana.xyz/admin_get_all_bank_payments/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    });

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      allPayments.assignAll(jsonData);
      for(var i in allPayments){
        if(i['date_created'] == date_created){
          allPaymentDates.add(i);
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
    getAllPayments();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments for $date_created"),
      ),
      body: isLoading
          ? const LoadingUi()
          : ListView.builder(
          itemCount:
          allPaymentDates != null ? allPaymentDates.length : 0,
          itemBuilder: (context, index) {
            items = allPaymentDates[index];
            return Card(
              color: secondaryColor,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: RowWidget(items: items, title: 'Agent: ', itemTitle: 'agent_username',),
                subtitle: Column(
                  children: [
                    RowWidget(items: items, title: 'MOD 1: ', itemTitle: 'mode_of_payment1',),
                    items['mode_of_payment2'] == "Select mode of payment" ? Container() : RowWidget(items: items, title: 'MOD 2: ', itemTitle: 'mode_of_payment2',),
                    items['cash_at_location1'] == "Please select cash at location" ? Container() :RowWidget(items: items, title: 'Cash @ Loc1: ', itemTitle: 'cash_at_location1',),
                    items['cash_at_location2'] == "Please select cash at location" ? Container() :RowWidget(items: items, title: 'Cash @ Loc2: ', itemTitle: 'cash_at_location2',),
                    items['bank1'] == "Select bank" ? Container() :RowWidget(items: items, title: 'Bank 1: ', itemTitle: 'bank1',),
                    items['bank2'] == "Select bank" ? Container() :RowWidget(items: items, title: 'Bank 2: ', itemTitle: 'bank2',),
                    RowWidget(items: items, title: 'Amount 1: ', itemTitle: 'amount1',),
                    items['amount2'] == "0.00" ? Container() :RowWidget(items: items, title: 'Amount 2: ', itemTitle: 'amount2',),
                    RowWidget(items: items, title: 'Trans Id1: ', itemTitle: 'transaction_id1',),
                    items['transaction_id2'] == "" ? Container() :RowWidget(items: items, title: 'Trans Id2: ', itemTitle: 'transaction_id2',),
                    RowWidget(items: items, title: 'Payment Status: ', itemTitle: 'payment_status',),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("Date: ",style: TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(items['date_created'],style: const TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
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
                          child: Text(items['time_created'].toString().split(".").first,style: const TextStyle(fontWeight: FontWeight.bold,color: defaultTextColor1),),
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
