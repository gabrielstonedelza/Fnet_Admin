import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/bankaccounts/updatebankaccounts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../controllers/bankaccountscontroller.dart';
import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';

class MyBankAccounts extends StatefulWidget {
  const MyBankAccounts({Key? key}) : super(key: key);

  @override
  State<MyBankAccounts> createState() => _MyBankAccountsState();
}

class _MyBankAccountsState extends State<MyBankAccounts> {
  final BankAccountsController controller = Get.find();
  late String uToken = "";
  final storage = GetStorage();
  var items;

  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      isPosting = false;
    });
  }

  bool isPosting = false;

  @override
  void initState() {
    super.initState();
    if (storage.read("token") != null) {
      setState(() {
        uToken = storage.read("token");
      });
    }
    controller.getAllMyBankAccounts(uToken);
  }

  deleteBankAccount(String id) async {
    final url = "https://fnetghana.xyz/delete_owner_bank_account/$id/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    });

    if (response.statusCode == 204) {
      controller.getAllMyBankAccounts(uToken);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bank Accounts"),
        // backgroundColor: secondaryColor,
        actions: [
          IconButton(
            onPressed: () {
              controller.getAllMyBankAccounts(uToken);
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: GetBuilder<BankAccountsController>(builder: (bController) {
        return ListView.builder(
            itemCount: bController.myBankAccounts != null
                ? bController.myBankAccounts.length
                : 0,
            itemBuilder: (context, index) {
              items = bController.myBankAccounts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: secondaryColor,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => UpdateMyAccount(
                          id: bController.myBankAccounts[index]['id']
                              .toString(),
                          acc_num: bController.myBankAccounts[index]
                              ['account_number'],
                          acc_name: bController.myBankAccounts[index]
                              ['account_name'],
                          bank: bController.myBankAccounts[index]['bank'],
                          phone_num: bController.myBankAccounts[index]['phone'],
                          linkedNum: bController.myBankAccounts[index]
                              ['mtn_linked_number']));
                    },
                    title: buildRow("Bank: ", "bank"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRow("ACC No : ", "account_number"),
                        buildRow("Acc Name : ", "account_name"),
                        buildRow("Phone: ", "phone"),
                        buildRow("Linked Num : ", "mtn_linked_number"),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 2),
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
                                items['date_added'].toString().split("T").first,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Tap to update accounts",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent)),
                        )
                      ],
                    ),
                    trailing: isPosting
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              _startPosting();
                              deleteBankAccount(bController
                                  .myBankAccounts[index]['id']
                                  .toString());
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: warning,
                              size: 30,
                            ),
                          ),
                  ),
                ),
              );
            });
      }),
    );
  }

  Padding buildRow(String mainTitle, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            items[subtitle],
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
