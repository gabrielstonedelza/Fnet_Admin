import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';

class CashSupportBalance extends StatefulWidget {
  final amount_received;
  final phone_number;
  const CashSupportBalance(
      {super.key, required this.amount_received, required this.phone_number});

  @override
  State<CashSupportBalance> createState() => _CashSupportBalanceState(
      amount_received: this.amount_received, phone_number: this.phone_number);
}

class _CashSupportBalanceState extends State<CashSupportBalance> {
  final amount_received;
  final phone_number;
  _CashSupportBalanceState(
      {required this.amount_received, required this.phone_number});
  var items;

  late double balanceRemaining = 0.0;
  late List customersCashSupportPaid = [];
  bool isLoading = true;

  Future<void> getAllCashSupportPaid() async {
    final profileLink =
        "https://fnetghana.xyz/get_all_customers_cash_support_paid/$phone_number/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      customersCashSupportPaid = jsonData;
      for (var i in customersCashSupportPaid) {
        balanceRemaining = balanceRemaining + double.parse(i['amount']);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getAllCashSupportPaid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultColor,
          title: const Text("Cash Support Balance",
              style: TextStyle(color: defaultTextColor1))),
      body: isLoading
          ? const LoadingUi()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 110,
                    child: Card(
                      color: secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Amount Received:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text("₵$amount_received",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Balance: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 17)),
                                  Text(
                                      "₵${double.parse(amount_received) - balanceRemaining}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 17)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 600,
                    child: ListView.builder(
                        itemCount: customersCashSupportPaid != null
                            ? customersCashSupportPaid.length
                            : 0,
                        itemBuilder: (context, index) {
                          items = customersCashSupportPaid[index];
                          return Card(
                            color: secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("₵${items['amount']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Row(
                                    children: [
                                      Text(
                                          items["date_added"]
                                              .toString()
                                              .split("T")
                                              .first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: defaultTextColor1,
                                              fontSize: 12)),
                                      const Text(" / ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: defaultTextColor1,
                                              fontSize: 12)),
                                      Text(
                                          items["date_added"]
                                              .toString()
                                              .split("T")
                                              .last
                                              .split(".")
                                              .first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: defaultTextColor1,
                                              fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
