import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cashsupportController.dart';
import '../../static/app_colors.dart';

class RedeemPointsRequests extends StatefulWidget {
  const RedeemPointsRequests({super.key});

  @override
  State<RedeemPointsRequests> createState() => _RedeemPointsRequestsState();
}

class _RedeemPointsRequestsState extends State<RedeemPointsRequests> {
  var items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultColor,
          title: const Text("Request to redeem points",
              style: TextStyle(color: defaultTextColor1))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CashSupportController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.customersRequestsToRedeemPoints != null
                  ? controller.customersRequestsToRedeemPoints.length
                  : 0,
              itemBuilder: (context, index) {
                items = controller.customersRequestsToRedeemPoints[index];
                return GestureDetector(
                  onTap: () {
                    Get.snackbar("Please wait", "approving request",
                        colorText: defaultTextColor1,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 5),
                        backgroundColor: snackColor);
                    controller.updateRedeemRequest(
                      controller.customersRequestsToRedeemPoints[index]['id']
                          .toString(),
                      controller.customersRequestsToRedeemPoints[index]
                          ['customer_phone'],
                      controller.customersRequestsToRedeemPoints[index]
                          ['customer_name'],
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
                                  const Text("Points:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: defaultTextColor1,
                                          fontSize: 17)),
                                  Text("₵${items['points']}",
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
                              child: Text("Tap to approve request"),
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
