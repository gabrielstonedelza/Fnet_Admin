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
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Card(
                            color: secondaryColor,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // shadowColor: Colors.pink,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, bottom: 18),
                              child: ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    deleteBankPayment(
                                        requestDates[i]['id'].toString());
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                                title: buildRow("Amount: ", "amount"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildRow(
                                        "Payment Approved: ", "payment_status"),
                                    items["reference"] == ""
                                        ? Container()
                                        : buildRow(
                                            "Reference: ", "transaction_id1"),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Date : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            items['date_created']
                                                .toString()
                                                .split("T")
                                                .first,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
