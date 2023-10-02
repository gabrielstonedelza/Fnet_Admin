import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/paymentscontroller.dart';
import '../../static/app_colors.dart';
import 'allpayments.dart';
import 'approvepayment.dart';

class AllPendingPayments extends StatefulWidget {
  const AllPendingPayments({super.key});

  @override
  State<AllPendingPayments> createState() => _AllPendingPaymentsState();
}

class _AllPendingPaymentsState extends State<AllPendingPayments> {
  final PaymentController paymentController = Get.find();
  var items;

  // late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentController.getAllPendingPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Payments"),
      ),
      body: GetBuilder<PaymentController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.pendingPayments != null
                ? controller.pendingPayments.length
                : 0,
            itemBuilder: (context, index) {
              items = controller.pendingPayments[index];
              return Card(
                color: secondaryColor,
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      () => ApprovePaymentDetail(
                        agent: controller.pendingPayments[index]['agent']
                            .toString(),
                        id: controller.pendingPayments[index]['id'].toString(),
                        bank: controller.pendingPayments[index]['bank1'],
                        bank2: controller.pendingPayments[index]['bank2'],
                        amount: controller.pendingPayments[index]['amount'],
                        transactionId: controller.pendingPayments[index]
                            ['transaction_id1'],
                        transactionId2: controller.pendingPayments[index]
                            ['transaction_id2'],
                        mop1: controller.pendingPayments[index]
                            ['mode_of_payment1'],
                        mop2: controller.pendingPayments[index]
                            ['mode_of_payment2'],
                        cla1: controller.pendingPayments[index]
                            ['cash_at_location1'],
                        cla2: controller.pendingPayments[index]
                            ['cash_at_location2'],
                      ),
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
                        title: 'MOD 1: ',
                        itemTitle: 'mode_of_payment1',
                      ),
                      items['mode_of_payment2'] == "Select mode of payment"
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
                              items['time_created'].toString().split(".").first,
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
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(() => const AllPayments());
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
