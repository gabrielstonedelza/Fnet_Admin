import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/getonlineimage.dart';
import 'banks/access.dart';
import 'banks/allbankdeposits.dart';
import 'banks/calbank.dart';
import 'banks/ecobank.dart';
import 'banks/fidelity.dart';
import 'banks/gtbank.dart';

class BankDepositSummary extends StatefulWidget {
  final username;
  final phone;

  const BankDepositSummary(
      {Key? key, required this.username, required this.phone})
      : super(key: key);

  @override
  State<BankDepositSummary> createState() =>
      _BankDepositSummaryState(username: this.username, phone: this.phone);
}

class _BankDepositSummaryState extends State<BankDepositSummary> {
  final username;
  final phone;

  _BankDepositSummaryState({required this.username, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$username's Bank Deposit Summary"),
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
                        myOnlineImage("assets/images/gtbank.jpg", 70, 70),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("GT"),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => GtBankDepositRequests(
                          username: username, phone: phone));
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        myOnlineImage(
                            "assets/images/fidelity-card.png", 70, 70),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Fidelity"),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => FidelityBankDepositRequests(
                          username: username, phone: phone));
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        myOnlineImage("assets/images/accessbank.png", 70, 70),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Access"),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => AccessBankDepositRequests(
                          username: username, phone: phone));
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
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        myOnlineImage("assets/images/calbank.png", 70, 70),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Cal"),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => CalBankDepositRequests(
                          username: username, phone: phone));
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        myOnlineImage(
                            "assets/images/ecomobile-card.png", 70, 70),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Ecobank"),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => EcoBankDepositRequests(
                          username: username, phone: phone));
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        myOnlineImage("assets/images/bank-account.png", 70, 70),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("All"),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => AllBankDepositRequests(
                          username: username, phone: phone));
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
