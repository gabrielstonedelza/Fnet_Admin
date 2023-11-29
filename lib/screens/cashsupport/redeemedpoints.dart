import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cashsupportController.dart';
import '../../static/app_colors.dart';

class CustomersRedeemPoints extends StatefulWidget {
  const CustomersRedeemPoints({super.key});

  @override
  State<CustomersRedeemPoints> createState() => _CustomersRedeemPointsState();
}

class _CustomersRedeemPointsState extends State<CustomersRedeemPoints> {
  var items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultColor,
          title: const Text("Redeemed points",
              style: TextStyle(color: defaultTextColor1))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CashSupportController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.customersRedeemPoints != null
                  ? controller.customersRedeemPoints.length
                  : 0,
              itemBuilder: (context, index) {
                items = controller.customersRedeemPoints[index];
                return SizedBox(
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
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
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
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
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
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
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
                                    items['date_created']
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
                        ],
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
