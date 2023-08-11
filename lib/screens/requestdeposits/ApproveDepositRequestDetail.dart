import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:ussd_advanced/ussd_advanced.dart';
import '../../static/app_colors.dart';
import '../homepage.dart';

class ApproveDepositRequestDetail extends StatefulWidget {
  final id;
  final agent;
  const ApproveDepositRequestDetail({super.key,required this.agent,required this.id});

  @override
  State<ApproveDepositRequestDetail> createState() => _ApproveDepositRequestDetailState(id:this.id,agent:this.agent);
}

class _ApproveDepositRequestDetailState extends State<ApproveDepositRequestDetail> {
  final id;
  final agent;

  Future<void>openOwnerFinancialServicesPushToBank() async {
    await UssdAdvanced.multisessionUssd(code: "*171*6*1*1#", subscriptionId: 1);
  }

  Future<void> openFinancialServicesPullFromBank() async {
    await UssdAdvanced.multisessionUssd(code: "*171*6*1*2#", subscriptionId: 1);
  }
  _ApproveDepositRequestDetailState({required this.agent,required this.id});
  Future<void> fetchAllInstalled() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true, includeSystemApps: true,includeAppIcons: false);
    // if (kDebugMode) {
    //   print(apps);
    // }
  }

  void showInstalled() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Card(
        elevation: 12,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10))),
        child: SizedBox(
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Text("Continue with mtn's financial services",
                      style: TextStyle(
                          fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async{
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async{
                      DeviceApps.openApp('accessmob.accessbank.com.accessghana');
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      DeviceApps.openApp('firstmob.firstbank.com.fbnsubsidiary');
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),
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
  approveRequest()async{
    final accountUrl = "https://www.fnetghana.xyz/admin_approve_bank_deposit_paid/$id/";
    final myLink = Uri.parse(accountUrl);
    http.Response response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token ${uToken.value}"
    }, body: {
      "agent": agent,
      "request_status": "Approved",
    });
    if (response.statusCode == 201) {
      Get.snackbar("Success", "users request was approved",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor);
      showInstalled();
      Get.offAll(() => const HomePage());
    } else {
      Get.snackbar("Account", "something went wrong,please try again later",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: warning);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllInstalled();
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
