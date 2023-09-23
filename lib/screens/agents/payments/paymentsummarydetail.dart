import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../sendsms.dart';
import '../../../static/app_colors.dart';
import '../../../widgets/loadingui.dart';

class PaymentSummaryDetail extends StatefulWidget {
  final date_created;
  final username;
  final phone;

  const PaymentSummaryDetail(
      {Key? key,
      this.date_created,
      required this.username,
      required this.phone})
      : super(key: key);

  @override
  _PaymentSummaryDetailState createState() => _PaymentSummaryDetailState(
      date_created: this.date_created,
      username: this.username,
      phone: this.phone);
}

class _PaymentSummaryDetailState extends State<PaymentSummaryDetail> {
  final date_created;
  final username;
  final phone;

  _PaymentSummaryDetailState(
      {required this.date_created,
      required this.username,
      required this.phone});

  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late List allPayments = [];
  bool isLoading = true;
  late var items;
  late List amounts = [];
  late List amountResults = [];
  late List requestDates = [];
  double sum = 0.0;
  bool isPosting = false;
  final SendSmsController sendSms = SendSmsController();

  Future<void> fetchAllPaymentRequests() async {
    final url = "https://fnetghana.xyz/user_transaction_payments/$username/";
    var myLink = Uri.parse(url);
    final response =
        await http.get(myLink, headers: {"Authorization": "Token $uToken"});

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allPayments = json.decode(jsonData);
      for (var i in allPayments) {
        if (i['date_created'].toString().split("T").first == date_created) {
          requestDates.add(i);
          sum = sum + double.parse(i['amount']);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  deleteBankPayment(String id) async {
    final url = "https://fnetghana.xyz/admin_delete_bank_payment/$id/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    String telnum = phone;
    telnum = telnum.replaceFirst("0", '+233');
    sendSms.sendMySms(telnum, "FNET", "Hello,your payment is cancelled");

    if (response.statusCode == 204) {
      Get.snackbar("Success", "Payment was deleted",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
          backgroundColor: snackBackground);
      setState(() {
        isPosting = false;
      });
      // Get.offAll(() => const HomePage());
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (storage.read("token") != null) {
      setState(() {
        hasToken = true;
        uToken = storage.read("token");
      });
    }
    fetchAllPaymentRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment summary for $date_created"),
      ),
      body: SafeArea(
          child: isLoading
              ? const LoadingUi()
              : ListView.builder(
                  itemCount: requestDates != null ? requestDates.length : 0,
                  itemBuilder: (context, i) {
                    items = requestDates[i];
                    return Card(
                      color: secondaryColor,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            deleteBankPayment(requestDates[i]['id'].toString());
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                        title: RowWidget(
                          items: items,
                          title: 'Agent: ',
                          itemTitle: 'agent_username',
                        ),
                        subtitle: Column(
                          children: [
                            RowWidget(
                              items: items,
                              title: 'MOD 1: ',
                              itemTitle: 'mode_of_payment1',
                            ),
                            items['mode_of_payment2'] ==
                                    "Select mode of payment"
                                ? Container()
                                : RowWidget(
                                    items: items,
                                    title: 'MOD 2: ',
                                    itemTitle: 'mode_of_payment2',
                                  ),
                            items['cash_at_location1'] ==
                                    "Please select cash at location"
                                ? Container()
                                : RowWidget(
                                    items: items,
                                    title: 'Cash @ Loc1: ',
                                    itemTitle: 'cash_at_location1',
                                  ),
                            items['cash_at_location2'] ==
                                    "Please select cash at location"
                                ? Container()
                                : RowWidget(
                                    items: items,
                                    title: 'Cash @ Loc2: ',
                                    itemTitle: 'cash_at_location2',
                                  ),
                            items['bank1'] == "Select bank"
                                ? Container()
                                : RowWidget(
                                    items: items,
                                    title: 'Bank 1: ',
                                    itemTitle: 'bank1',
                                  ),
                            items['bank2'] == "Select bank"
                                ? Container()
                                : RowWidget(
                                    items: items,
                                    title: 'Bank 2: ',
                                    itemTitle: 'bank2',
                                  ),
                            RowWidget(
                              items: items,
                              title: 'Amount 1: ',
                              itemTitle: 'amount1',
                            ),
                            items['amount2'] == "0.00"
                                ? Container()
                                : RowWidget(
                                    items: items,
                                    title: 'Amount 2: ',
                                    itemTitle: 'amount2',
                                  ),
                            RowWidget(
                              items: items,
                              title: 'Trans Id1: ',
                              itemTitle: 'transaction_id1',
                            ),
                            items['transaction_id2'] == ""
                                ? Container()
                                : RowWidget(
                                    items: items,
                                    title: 'Trans Id2: ',
                                    itemTitle: 'transaction_id2',
                                  ),
                            RowWidget(
                              items: items,
                              title: 'Payment Status: ',
                              itemTitle: 'payment_status',
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    "Date: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    items['date_created'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    "Time: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    items['time_created']
                                        .toString()
                                        .split(".")
                                        .first,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
      floatingActionButton: !isLoading
          ? FloatingActionButton(
              backgroundColor: snackBackground,
              child: const Text("Total"),
              onPressed: () {
                Get.defaultDialog(
                  buttonColor: secondaryColor,
                  title: "Total",
                  middleText: "$sum",
                  confirm: RawMaterialButton(
                      shape: const StadiumBorder(),
                      fillColor: secondaryColor,
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      )),
                );
              },
            )
          : Container(),
    );
  }

  Padding buildRow(String mainTitle, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            items[subtitle].toString(),
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  String title;
  String itemTitle;
  RowWidget(
      {super.key,
      required this.items,
      required this.title,
      required this.itemTitle});

  final items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: defaultTextColor1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 8),
          child: Text(
            items[itemTitle],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: defaultTextColor1),
          ),
        ),
      ],
    );
  }
}
