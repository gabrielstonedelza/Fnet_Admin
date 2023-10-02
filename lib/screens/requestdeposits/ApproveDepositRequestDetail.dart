import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

import '../../static/app_colors.dart';
import '../bankaccounts/getaccountsandpull.dart';
import '../bankaccounts/getaccountsandpush.dart';
import '../homepage.dart';
import '../newhomepage.dart';

class ApproveDepositRequestDetail extends StatefulWidget {
  final id;
  final agent;
  final bank;
  final amount;
  final accnum;
  final userLoc;
  final userLocDist;

  const ApproveDepositRequestDetail(
      {super.key,
      required this.agent,
      required this.id,
      required this.amount,
      required this.bank,
      required this.accnum,
      required this.userLoc,
      required this.userLocDist});

  @override
  State<ApproveDepositRequestDetail> createState() =>
      _ApproveDepositRequestDetailState(
        id: this.id,
        agent: this.agent,
        amount: this.amount,
        bank: this.bank,
        accnum: this.accnum,
        userLoc: this.userLoc,
        userLocDist: this.userLocDist,
      );
}

class _ApproveDepositRequestDetailState
    extends State<ApproveDepositRequestDetail> {
  final id;
  final agent;
  final bank;
  final amount;
  final accnum;
  final userLoc;
  final userLocDist;

  Future<void> openOwnerFinancialServicesPushToBank() async {
    await UssdAdvanced.multisessionUssd(code: "*171*6*1*1#", subscriptionId: 1);
  }

  Future<void> openFinancialServicesPullFromBank() async {
    await UssdAdvanced.multisessionUssd(code: "*171*6*1*2#", subscriptionId: 1);
  }

  _ApproveDepositRequestDetailState({
    required this.agent,
    required this.id,
    required this.amount,
    required this.bank,
    required this.accnum,
    required this.userLoc,
    required this.userLocDist,
  });

  Future<void> fetchAllInstalled() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true,
        includeAppIcons: false);
    // if (kDebugMode) {
    //   print(apps);
    // }
  }

  var myDefaultCardColor = Colors.white;
  var gtBankColor = const Color(0xFFFB5607);
  var ecoBanColor = Colors.blue;
  var fidelityColor = Colors.orange;
  var calBankColor = Colors.yellow;
  var accessBankColor = Colors.greenAccent;
  var fbankColor = Colors.lightBlueAccent;
  bool isPosting = false;

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
                      // openOwnerFinancialServicesPushToBank();
                      // openFinancialServices();
                      // openMyFinancialServices();
                      Get.to(() => const GetMyAccountsAndPush());
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
                      // openFinancialServicesPullFromBank();
                      Get.to(() => const GetMyAccountsAndPull());
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

  approveRequest() async {
    final accountUrl =
        "https://www.fnetghana.xyz/admin_approve_bank_deposit_paid/$id/";
    final myLink = Uri.parse(accountUrl);
    http.Response response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token ${uToken.value}"
    }, body: {
      "agent": agent,
      "request_status": "Approved",
      "user_location": userLoc,
      "user_local_district": userLocDist,
    });
    if (response.statusCode == 200) {
      Get.snackbar("Success", "users request was approved",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor);
      setState(() {
        isPosting = false;
      });
      // showInstalled();
      Get.offAll(() => const NewHomePage());
      showInstalled();
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

  deleteBankRequest(String id) async {
    final url = "https://fnetghana.xyz/admin_delete_bank_request/$id/";
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
    fetchAllInstalled();
  }

  @override
  Widget build(BuildContext context) {
    switch (bank) {
      case "GT Bank":
        setState(() {
          myDefaultCardColor = gtBankColor;
        });
        break;
      case "Access Bank":
        setState(() {
          myDefaultCardColor = accessBankColor;
        });
        break;
      case "Cal Bank":
        setState(() {
          myDefaultCardColor = calBankColor;
        });
        break;
      case "Ecobank":
        setState(() {
          myDefaultCardColor = ecoBanColor;
        });
        break;
      case "Fidelity Bank":
        setState(() {
          myDefaultCardColor = fidelityColor;
        });
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approve Request"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Card(
            color: myDefaultCardColor,
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
                      Text("Amount: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: bank == "Access Bank" || bank == "Cal Bank"
                                  ? Colors.black
                                  : defaultTextColor1)),
                      Text(amount,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: bank == "Access Bank" || bank == "Cal Bank"
                                  ? Colors.black
                                  : defaultTextColor1)),
                    ],
                  ),
                ),
                subtitle: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text("Bank : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: bank == "Access Bank" ||
                                          bank == "Cal Bank"
                                      ? Colors.black
                                      : defaultTextColor1)),
                          Text(bank,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: bank == "Access Bank" ||
                                          bank == "Cal Bank"
                                      ? Colors.black
                                      : defaultTextColor1)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text("Acc No : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    bank == "Access Bank" || bank == "Cal Bank"
                                        ? Colors.black
                                        : defaultTextColor1)),
                        Text(accnum,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    bank == "Access Bank" || bank == "Cal Bank"
                                        ? Colors.black
                                        : defaultTextColor1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          isPosting
              ? const LoadingUi()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          isPosting = true;
                        });
                        approveRequest();
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
                        deleteBankRequest(id);
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
        ],
      ),
    );
  }
}
