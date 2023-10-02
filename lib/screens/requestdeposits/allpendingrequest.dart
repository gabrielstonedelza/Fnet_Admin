import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/requestcontroller.dart';
import '../../static/app_colors.dart';
import 'ApproveDepositRequestDetail.dart';
import 'allrequests.dart';

class AllPendingDepositRequests extends StatefulWidget {
  const AllPendingDepositRequests({super.key});

  @override
  State<AllPendingDepositRequests> createState() =>
      _AllPendingDepositRequestsState();
}

class _AllPendingDepositRequestsState extends State<AllPendingDepositRequests> {
  final RequestController requestController = Get.find();
  var items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestController.getAllPendingRequestDeposits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Requests"),
      ),
      body: GetBuilder<RequestController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.allPendingRequests != null
                ? controller.allPendingRequests.length
                : 0,
            itemBuilder: (context, index) {
              items = controller.allPendingRequests[index];
              return Card(
                color: secondaryColor,
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      () => ApproveDepositRequestDetail(
                          agent: controller.allPendingRequests[index]['agent']
                              .toString(),
                          id: controller.allPendingRequests[index]['id']
                              .toString(),
                          bank: controller.allPendingRequests[index]['bank'],
                          amount: controller.allPendingRequests[index]
                              ['amount'],
                          accnum: controller.allPendingRequests[index]
                              ['account_number'],
                          userLoc: controller.allPendingRequests[index]
                              ['user_location'],
                          userLocDist: controller.allPendingRequests[index]
                              ['user_local_district']),
                    );
                  },
                  title: RowWidget(
                    items: items,
                    title: 'Agent: ',
                    itemTitle: 'agent_username',
                  ),
                  subtitle: Column(
                    children: [
                      RowWidget(
                        items: items,
                        title: 'Location: ',
                        itemTitle: 'user_location',
                      ),
                      RowWidget(
                        items: items,
                        title: 'Local District: ',
                        itemTitle: 'user_local_district',
                      ),
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
                      const Text("Tap to approve",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))
                    ],
                  ),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Get.to(() => const AllDepositRequests());
        },
        child: const Text("All"),
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
