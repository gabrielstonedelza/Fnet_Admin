import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/customers/searchcustomers.dart';
import 'package:fnet_admin/screens/customers/updatecustomer.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controllers/customerscontroller.dart';
import '../../static/app_colors.dart';

class AllCustomers extends StatefulWidget {
  const AllCustomers({super.key});

  @override
  State<AllCustomers> createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  final CustomersController controller = Get.find();
  var items;
  late List allCustomers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers (${controller.allCustomers.length})"),
      ),
      body: GetBuilder<CustomersController>(
        builder: (cController) {
          return ListView.builder(
              itemCount: cController.allCustomers != null
                  ? cController.allCustomers.length
                  : 0,
              itemBuilder: (context, index) {
                items = cController.allCustomers[index];
                return Card(
                  color: secondaryColor,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    // leading: const Icon(Icons.person),
                    onTap: () {
                      Get.to(() => UpdateCustomer(
                            id: cController.allCustomers[index]['id']
                                .toString(),
                            customerName: cController.allCustomers[index]
                                ['name'],
                            phone: cController.allCustomers[index]['phone'],
                            customerLocation: cController.allCustomers[index]
                                ['location'],
                            digitAddress: cController.allCustomers[index]
                                ['digital_address'],
                            customerDob: cController.allCustomers[index]
                                ['date_of_birth'],
                          ));
                    },
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          const Text(
                            "Name: ",
                            style: TextStyle(
                                color: defaultTextColor1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            items['name'],
                            style: const TextStyle(
                                color: defaultTextColor1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Phone: ",
                              style: TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              items['phone'],
                              style: const TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Location: ",
                              style: TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              items['location'],
                              style: const TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Dig Add: ",
                              style: TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              items['digital_address'],
                              style: const TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Dob: ",
                              style: TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              items['date_of_birth'],
                              style: const TextStyle(
                                  color: defaultTextColor1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 18.0, bottom: 8),
                          child: Text("Tap to edit customer"),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(() => const SearchCustomers());
        },
        child: Image.asset(
          "assets/images/recruitment.png",
          width: 30,
          height: 30,
          color: defaultTextColor1,
        ),
      ),
    );
  }
}
