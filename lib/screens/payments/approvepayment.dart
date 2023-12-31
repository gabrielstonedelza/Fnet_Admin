import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

import '../../static/app_colors.dart';
import '../homepage.dart';
import '../newhomepage.dart';

class ApprovePaymentDetail extends StatefulWidget {
  final id;
  final agent;
  final bank;
  final amount;
  final transactionId;
  final bank2;
  final transactionId2;
  final mop1;
  final mop2;
  final cla1;
  final cla2;

  const ApprovePaymentDetail(
      {super.key,
      required this.agent,
      required this.id,
      required this.amount,
      required this.bank,
      required this.transactionId,
      required this.bank2,
      required this.transactionId2,
      required this.mop1,
      required this.mop2,
      required this.cla1,
      required this.cla2});

  @override
  State<ApprovePaymentDetail> createState() => _ApprovePaymentDetailState(
        id: this.id,
        agent: this.agent,
        amount: this.amount,
        bank: this.amount,
        transactionId: this.transactionId,
        bank2: this.bank2,
        transactionId2: this.transactionId,
        mop1: this.mop1,
        mop2: this.mop2,
        cla1: this.cla1,
        cla2: this.cla2,
      );
}

class _ApprovePaymentDetailState extends State<ApprovePaymentDetail> {
  final id;
  final agent;
  final bank;
  final amount;
  final transactionId;
  final bank2;
  final transactionId2;
  final mop1;
  final mop2;
  final cla1;
  final cla2;

  Future<void> openOwnerFinancialServicesPushToBank() async {
    await UssdAdvanced.multisessionUssd(code: "*171*6*1*1#", subscriptionId: 1);
  }

  Future<void> openFinancialServicesPullFromBank() async {
    await UssdAdvanced.multisessionUssd(code: "*171*6*1*2#", subscriptionId: 1);
  }

  _ApprovePaymentDetailState(
      {required this.agent,
      required this.id,
      required this.amount,
      required this.bank,
      required this.transactionId,
      required this.bank2,
      required this.transactionId2,
      required this.mop1,
      required this.mop2,
      required this.cla1,
      required this.cla2});

  Future<void> fetchAllInstalled() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true,
        includeAppIcons: false);
    // if (kDebugMode) {
    //   print(apps);
    // }
  }

  bool isPosting = false;
  late final TextEditingController _tIdController;

  void showInstalled() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Card(
        elevation: 12,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: SizedBox(
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text("Continue with mtn's financial services",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      openOwnerFinancialServicesPushToBank();
                      // openFinancialServices();
                      // openMyFinancialServices();
                      // Get.to(() => const GetMyAccountsAndPush());
                      // Get.back();
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/momo.png",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("Push USSD",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DeviceApps.openApp('com.mtn.agentapp');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/momo.png",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("MTN App",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // openFinancialServicesPullFromBank();
                      openFinancialServicesPullFromBank();
                      // Get.to(() => const GetMyAccountsAndPull());
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/momo.png",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("Pull USSD",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
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
              const Center(
                  child: Text("Continue with apps",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      DeviceApps.openApp('com.ecobank.xpresspoint');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/xpresspoint.png",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("Express Point",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DeviceApps.openApp('sg.android.fidelity');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/fidelity-card.png",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("Fidelity Bank",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DeviceApps.openApp('calbank.com.ams');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/calbank.png",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("Cal Bank",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      DeviceApps.openApp(
                          'accessmob.accessbank.com.accessghana');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/accessbank.png",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("Access Bank",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DeviceApps.openApp('com.m2i.gtexpressbyod');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/gtbank.jpg",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("GT Bank",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DeviceApps.openApp(
                          'firstmob.firstbank.com.fbnsubsidiary');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/full-branch.jpg",
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text("FBN Bank",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  approvePayment() async {
    final accountUrl =
        "https://www.fnetghana.xyz/admin_approve_bank_payments_paid/$id/";
    final myLink = Uri.parse(accountUrl);
    http.Response response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token ${uToken.value}"
    }, body: {
      "agent": agent,
      "payment_status": "Approved",
    });
    if (response.statusCode == 200) {
      Get.snackbar("Success", "users payment was approved",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor);
      setState(() {
        isPosting = false;
      });
      // showInstalled();
      Get.offAll(() => const NewHomePage());
      // showInstalled();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      Get.snackbar("Account", "something went wrong,please try again later",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: warning);
    }
  }

  bool isEquals = false;

  deleteBankPayment(String id) async {
    final url = "https://fnetghana.xyz/admin_delete_bank_payment/$id/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 204) {
      setState(() {
        isPosting = false;
      });
      Get.offAll(() => const NewHomePage());
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tIdController = TextEditingController();
    fetchAllInstalled();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approve Payment"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Card(
            color: secondaryColor,
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Text("Amount: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: defaultTextColor1)),
                      Text(amount,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: defaultTextColor1)),
                    ],
                  ),
                ),
                subtitle: Column(
                  children: [
                    mop1 != "Select mode of payment"
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Text("Mode of payment1: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                                Text(mop1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                              ],
                            ),
                          )
                        : Container(),
                    mop2 != "Select mode of payment"
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Text("Mode of payment2: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                                Text(mop2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                              ],
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          const Text("Bank1: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: defaultTextColor1)),
                          Text(bank,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: defaultTextColor1)),
                        ],
                      ),
                    ),
                    bank2 != "Select bank"
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Text("Bank2: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                                Text(bank2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                              ],
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          const Text("Transaction Id1: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: defaultTextColor1)),
                          Text(transactionId,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: defaultTextColor1)),
                        ],
                      ),
                    ),
                    transactionId2 != ""
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Text("Transaction Id2: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                                Text(transactionId2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                              ],
                            ),
                          )
                        : Container(),
                    cla1 != "Please select cash at location"
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Text("Cash Left @1: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                                Text(cla1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                              ],
                            ),
                          )
                        : Container(),
                    cla2 != "Please select cash at location"
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Text("Cash Left @2: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                                Text(cla2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: defaultTextColor1)),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              onChanged: (value) {
                if (value.length == transactionId.length &&
                    value == transactionId) {
                  setState(() {
                    isEquals = true;
                  });
                } else {
                  setState(() {
                    isEquals = false;
                  });
                }
              },
              // readOnly: true,
              controller: _tIdController,
              cursorColor: secondaryColor,
              cursorRadius: const Radius.elliptical(10, 10),
              cursorWidth: 10,
              decoration: buildInputDecoration("Enter Transaction Id"),
              keyboardType: TextInputType.text,
            ),
          ),
          isPosting
              ? const LoadingUi()
              : isEquals
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              isPosting = true;
                            });
                            approvePayment();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 8,
                          fillColor: primaryColor,
                          splashColor: defaultColor,
                          child: const Text(
                            "Approve",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              isPosting = true;
                            });
                            deleteBankPayment(id);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 8,
                          fillColor: primaryColor,
                          splashColor: defaultColor,
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  : Container()
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(String text) {
    return InputDecoration(
      labelStyle: const TextStyle(color: secondaryColor),
      labelText: text,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor, width: 2),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
