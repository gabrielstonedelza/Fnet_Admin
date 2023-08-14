import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';

class AllUnPaidRequests extends StatefulWidget {
  const AllUnPaidRequests({super.key});

  @override
  State<AllUnPaidRequests> createState() => _AllUnPaidRequestsState();
}

class _AllUnPaidRequestsState extends State<AllUnPaidRequests> {
  late List unPaidDepositRequests = [];
  bool isLoading = true;
  var items;

  Future<void> getAllUnpaidDepositRequests() async {
    const url = "https://fnetghana.xyz/get_agents_unpaid_deposits/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      var deData = json.decode(jsonData);
      unPaidDepositRequests.assignAll(deData);
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
    // TODO: implement initState
    super.initState();
    getAllUnpaidDepositRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unpaid Requests (${unPaidDepositRequests.length})"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                getAllUnpaidDepositRequests();
              },
              icon:
                  const Icon(Icons.refresh, size: 30, color: defaultTextColor1))
        ],
      ),
      body: isLoading
          ? const LoadingUi()
          : ListView.builder(
              itemCount: unPaidDepositRequests != null
                  ? unPaidDepositRequests.length
                  : 0,
              itemBuilder: (context, index) {
                items = unPaidDepositRequests[index];
                return Card(
                  color: secondaryColor,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
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
                              padding: const EdgeInsets.only(bottom: 8),
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
                              padding: const EdgeInsets.only(bottom: 8),
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
                );
              }),
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
