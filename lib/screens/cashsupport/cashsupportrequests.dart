import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cashsupportController.dart';
import '../../static/app_colors.dart';
import 'addcustomertocashsupport.dart';

class CashSupportRequests extends StatefulWidget {
  const CashSupportRequests({super.key});

  @override
  State<CashSupportRequests> createState() => _CashSupportRequestsState();
}

class _CashSupportRequestsState extends State<CashSupportRequests> {
  var items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultColor,
          title: const Text("Cash Support Requests",
              style: TextStyle(color: defaultTextColor1))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CashSupportController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.customersCashSupportRequests != null
                  ? controller.customersCashSupportRequests.length
                  : 0,
              itemBuilder: (context, index) {
                items = controller.customersCashSupportRequests[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => AddCustomerToCashSupport(
                          id: controller.customersCashSupportRequests[index]
                                  ['id']
                              .toString(),
                          phone: controller.customersCashSupportRequests[index]
                              ['customer_phone'],
                          name: controller.customersCashSupportRequests[index]
                              ['customer_name'],
                          amount: controller.customersCashSupportRequests[index]
                                  ['amount']
                              .toString()),
                    );
                  },
                  child: SizedBox(
                    height: 210,
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
                                  const Text("Amount Requested:  ",
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
                                  const Text("Date Requested: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text(
                                      items['date_requested']
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
                              child: Text("Tap to grant customer request"),
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
