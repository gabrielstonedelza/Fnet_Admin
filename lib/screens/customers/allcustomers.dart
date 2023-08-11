import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
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
                    title: Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 8),
                      child: Row(
                        children: [
                          const Text("Name: "),
                          Text(items['name']),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Phone: "),
                            Text(items['phone']),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Location: "),
                            Text(items['location']),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Dig Add: "),
                            Text(items['digital_address']),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Dob: "),
                            Text(items['date_of_birth']),
                          ],
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
