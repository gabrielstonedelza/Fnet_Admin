import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/cashsupportController.dart';
import '../../static/app_colors.dart';
import 'cashsupportbalance.dart';

class CashSupportSummary extends StatefulWidget {
  const CashSupportSummary({super.key});

  @override
  State<CashSupportSummary> createState() => _CashSupportSummaryState();
}

class _CashSupportSummaryState extends State<CashSupportSummary> {
  var items;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultColor,
          title: const Text("Cash Support",
              style: TextStyle(color: defaultTextColor1))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CashSupportController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.customersCashSupport != null
                  ? controller.customersCashSupport.length
                  : 0,
              itemBuilder: (context, index) {
                items = controller.customersCashSupport[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => CashSupportBalance(
                          amount_received: controller
                              .customersCashSupport[index]['amount']
                              .toString(),
                          phone_number: controller.customersCashSupport[index]
                              ['customer_phone'],
                        ));
                  },
                  child: SizedBox(
                    height: 250,
                    child: Card(
                      color: secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: [
                                  const Text("Customer:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text(items['customer_name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: [
                                  const Text("Phone:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text(items['customer_phone'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: [
                                  const Text("Amount Received:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text("₵${items['amount']}",
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
                                children: [
                                  const Text("Interest: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text("₵${items['interest']}",
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
                                children: [
                                  const Text("Date Requested: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text(
                                      items['date_added']
                                          .toString()
                                          .split("T")
                                          .first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text("Tap to see balance"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
