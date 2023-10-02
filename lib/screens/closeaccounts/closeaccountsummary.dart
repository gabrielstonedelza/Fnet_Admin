import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/closeaccountcontroller.dart';
import '../../static/app_colors.dart';
import 'closeaccounts.dart';
import 'closedaccount.dart';

class CloseAccountSummary extends StatefulWidget {
  const CloseAccountSummary({Key? key}) : super(key: key);

  @override
  State<CloseAccountSummary> createState() => _CloseAccountSummaryState();
}

class _CloseAccountSummaryState extends State<CloseAccountSummary> {
  final CloseAccountsController controller = Get.find();
  var items;
  final storage = GetStorage();
  late String uToken = "";

  @override
  void initState() {
    // TODO: implement initState
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    controller.getAllMyClosedAccounts(uToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Summary"),
        actions: [
          IconButton(
            onPressed: () {
              controller.getAllMyClosedAccounts(uToken);
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: GetBuilder<CloseAccountsController>(
        builder: (aController) {
          return ListView.builder(
              itemCount: aController.allClosedAccountsDates != null
                  ? aController.allClosedAccountsDates.length
                  : 0,
              itemBuilder: (context, i) {
                items = aController.allClosedAccountsDates[i];
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CloseAccount(
                              date_created:
                                  aController.allClosedAccountsDates[i]);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Card(
                          color: secondaryColor,
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // shadowColor: Colors.pink,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      items,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Get.to(() => const AddCloseAccount());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
