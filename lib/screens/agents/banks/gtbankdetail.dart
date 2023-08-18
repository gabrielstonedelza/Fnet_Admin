import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../sendsms.dart';
import '../../../static/app_colors.dart';
import '../../../widgets/loadingui.dart';

class GTBankSummaryDetail extends StatefulWidget {
  final date_requested;
  final username;
  final phone;

  const GTBankSummaryDetail(
      {Key? key,
      this.date_requested,
      required this.username,
      required this.phone})
      : super(key: key);

  @override
  _GTBankSummaryDetailState createState() => _GTBankSummaryDetailState(
        date_requested: this.date_requested,
        username: this.username,
        phone: this.phone,
      );
}

class _GTBankSummaryDetailState extends State<GTBankSummaryDetail> {
  final date_requested;
  final username;
  final phone;

  _GTBankSummaryDetailState(
      {required this.date_requested,
      required this.username,
      required this.phone});

  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late List allGTRequests = [];
  bool isLoading = true;
  late var items;
  late List amounts = [];
  late List amountResults = [];
  late List requestDates = [];
  double sum = 0.0;
  final SendSmsController sendSms = SendSmsController();

  fetchAllPaymentRequests() async {
    final url = "https://fnetghana.xyz/get_agents_gt_bank/$username/";
    var myLink = Uri.parse(url);
    final response = await http.get(
      myLink,
    );

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allGTRequests = json.decode(jsonData);
      for (var i in allGTRequests) {
        if (i['date_requested'].toString().split("T").first == date_requested) {
          requestDates.add(i);
          sum = sum + double.parse(i['amount']);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  deleteBankRequest(String id) async {
    final url = "https://fnetghana.xyz/admin_delete_bank_request/$id/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 204) {
      String telnum = phone;
      telnum = telnum.replaceFirst("0", '+233');
      sendSms.sendMySms(
          telnum, "FNET", "Hello,your GT Bank request is cancelled");
      Get.snackbar("Success", "Request was deleted",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
          backgroundColor: snackBackground);
      setState(() {
        isLoading = false;
      });
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
        title: Text("GT summary for $date_requested"),
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
                            child: ListTile(
                              trailing: IconButton(
                                onPressed: () {
                                  deleteBankRequest(
                                      requestDates[i]['id'].toString());
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
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
                                    title: 'Customer: ',
                                    itemTitle: 'customer',
                                  ),
                                  RowWidget(
                                    items: items,
                                    title: 'Bank: ',
                                    itemTitle: 'bank',
                                  ),
                                  RowWidget(
                                    items: items,
                                    title: 'Acc No: ',
                                    itemTitle: 'account_number',
                                  ),
                                  RowWidget(
                                    items: items,
                                    title: 'Acc Name: ',
                                    itemTitle: 'account_name',
                                  ),
                                  RowWidget(
                                    items: items,
                                    title: 'Amount: ',
                                    itemTitle: 'amount',
                                  ),
                                  RowWidget(
                                    items: items,
                                    title: 'Req Status: ',
                                    itemTitle: 'request_status',
                                  ),
                                  RowWidget(
                                    items: items,
                                    title: 'Req Paid: ',
                                    itemTitle: 'deposit_paid',
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
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          items['date_requested'],
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
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          items['time_requested']
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
