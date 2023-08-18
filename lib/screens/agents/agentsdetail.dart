import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/agents/payments/paymentsummary.dart';
import 'package:fnet_admin/screens/agents/reports/reportsummary.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../widgets/getonlineimage.dart';
import 'agentcustomers.dart';
import 'bankdeposits.dart';
import 'bankwithdrawals.dart';

class AgentDetails extends StatefulWidget {
  final username;
  final phone;

  const AgentDetails({Key? key, required this.username, required this.phone})
      : super(key: key);

  @override
  State<AgentDetails> createState() =>
      _AgentDetailsState(username: this.username, phone: this.phone);
}

class _AgentDetailsState extends State<AgentDetails> {
  final username;
  final phone;

  _AgentDetailsState({required this.username, required this.phone});

  final storage = GetStorage();
  late String uToken = "";

  @override
  void initState() {
    super.initState();

    if (storage.read("token") != null) {
      setState(() {
        uToken = storage.read("token");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details for $username"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      myOnlineImage("assets/images/group.png", 70, 70),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Customers"),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => AgentCustomers(
                          username: username,
                        ));
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      myOnlineImage("assets/images/bank.png", 70, 70),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Bank Deposits"),
                    ],
                  ),
                  onTap: () {
                    Get.to(() =>
                        BankDepositSummary(username: username, phone: phone));
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      myOnlineImage("assets/images/bank.png", 70, 70),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Bank Withdrawals"),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => BankWithdrawalSummary(username: username));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      myOnlineImage(
                          "assets/images/cashless-payment.png", 70, 70),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Payments"),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => PaymentSummary(
                          username: username,
                          phone: phone,
                        ));
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      myOnlineImage("assets/images/notebook.png", 70, 70),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Reports"),
                    ],
                  ),
                  onTap: () {
                    Get.to(() => ReportSummary(
                          username: username,
                        ));
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      // myOnlineImage("assets/images/bank.png",70,70),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // const Text("Bank Withdrawals"),
                    ],
                  ),
                  onTap: () {
                    // Get.to(() => BankWithdrawalSummary(username: username));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
