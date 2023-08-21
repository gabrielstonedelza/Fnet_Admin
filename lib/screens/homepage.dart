import 'dart:async';
import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart' as mySms;
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:fnet_admin/controllers/logincontroller.dart';
import 'package:fnet_admin/screens/payments/allpendingpayments.dart';
import 'package:fnet_admin/screens/points/points.dart';
import 'package:fnet_admin/screens/registeruser.dart';
import 'package:fnet_admin/screens/reports/reportsummary.dart';
import 'package:fnet_admin/screens/requestdeposits/allpendingrequest.dart';
import 'package:fnet_admin/screens/requestdeposits/unpaiddeposits.dart';
import 'package:fnet_admin/screens/sms/selectsms.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

import '../sendsms.dart';
import 'agents/allusers.dart';
import 'bankaccounts/getaccountsandpull.dart';
import 'bankaccounts/getaccountsandpush.dart';
import 'bankaccounts/mybankaccounts.dart';
import 'bankaccounts/registerbankaccounts.dart';
import 'birthdays.dart';
import 'customers/allcustomers.dart';
import 'loginview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  final LoginController controller = Get.find();
  final storage = GetStorage();
  late String uToken = "";
  late String username = "";
  bool isLoading = true;
  late List yourNotifications = [];
  late List notRead = [];
  late List triggered = [];
  late List unreadNotifications = [];
  late List triggeredNotifications = [];
  late List allNotifications = [];
  late List allNots = [];
  late List allCustomers = [];
  late Timer _timer;
  bool hasAlreadySent = false;
  late List sentBirthdays = [];
  String smsSent = "No";
  late List hasBirthDayInFive = [];
  late List hasBirthDayToday = [];
  late List todaysBirthdayPhones = [];
  bool hasbdinfive = false;
  bool hasbdintoday = false;
  late int sentCount = 1;
  bool isFetching = true;
  late DateDuration duration;
  final SendSmsController sendSms = SendSmsController();
  late List unPaidDepositRequests = [];

  Future<void> getAllUnpaidDepositRequests() async {
    const url = "https://fnetghana.xyz/get_agents_unpaid_deposits/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      var deData = json.decode(jsonData);
      unPaidDepositRequests.assignAll(deData);
      setState(() {
        isLoading = false;
      });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> fetchAllInstalled() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true,
        includeAppIcons: false);
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

  Future<void> getAllTriggeredNotifications() async {
    const url = "https://fnetghana.xyz/get_triggered_notifications/";
    var myLink = Uri.parse(url);
    final response =
        await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      triggeredNotifications = json.decode(jsonData);
      triggered.assignAll(triggeredNotifications);
    }
  }

  Future<void> getAllUnReadNotifications() async {
    const url = "https://fnetghana.xyz/get_user_notifications/";
    var myLink = Uri.parse(url);
    final response =
        await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      yourNotifications = json.decode(jsonData);
      notRead.assignAll(yourNotifications);
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllNotifications() async {
    const url = "https://fnetghana.xyz/get_all_user_notifications/";
    var myLink = Uri.parse(url);
    final response =
        await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allNotifications = json.decode(jsonData);
      allNots.assignAll(allNotifications);
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> unTriggerNotifications(int id) async {
    final requestUrl = "https://fnetghana.xyz/read_notification/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "notification_trigger": "Not Triggered",
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
    }
  }

  logoutUser() async {
    storage.remove("token");
    storage.remove("username");

    Get.offAll(() => const LoginView());
    const logoutUrl = "https://www.fnetghana.xyz/auth/token/logout";
    final myLink = Uri.parse(logoutUrl);
    http.Response response = await http.post(myLink, headers: {
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    });

    if (response.statusCode == 200) {
      Get.snackbar("Success", "You were logged out",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackBackground);
      storage.remove("token");
      storage.remove("username");
      Get.offAll(() => const LoginView());
    }
  }

  Future<void> fetchCustomersWithBirthDays() async {
    const url = "https://www.fnetghana.xyz/all_customers/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allCustomers = json.decode(jsonData);
      for (var i in allCustomers) {
        DateTime birthday = DateTime.parse(i['date_of_birth']);
        duration = AgeCalculator.timeToNextBirthday(birthday);
        if (duration.months == 0 && duration.days == 5) {
          hasBirthDayInFive.add(i['name']);
          hasbdinfive = true;
          if (storage.read("birthdaySent") != null &&
              storage.read("birthdaySent") == "Yes") {
            storage.remove("birthdaySent");
            storage.write("birthdaySent", smsSent);
          }
        }
        if (duration.months == 0 &&
            duration.days == 0 &&
            storage.read("birthdaySent") != null &&
            storage.read('birthdaySent') == "No") {
          if (duration.months == 0 && duration.days == 0) {
            hasbdintoday = true;
            hasBirthDayToday.add(i['name']);
            todaysBirthdayPhones.add(i['phone']);
            for (var b in todaysBirthdayPhones) {
              String birthdayNum = b;
              birthdayNum = birthdayNum.replaceFirst("0", '+233');
              sendSms.sendMySms(birthdayNum, "FNET",
                  "Hello, FNET ENTERPRISE is wishing you a happy birthday,may God grant all your heart desires,thank you.");
              sendSms.sendMySms(birthdayNum, "FNET",
                  "Download customer app from https://play.google.com/store/apps/details?id=com.fnettransaction.fnet_customer");
              sentBirthdays.add(b);
              smsSent = "Yes";
              storage.write("birthdaySent", smsSent);
            }
          }
        }
      }
    }
  }

  SmsQuery query = SmsQuery();
  late List mySmss = [];

  fetchInbox() async {
    List<mySms.SmsMessage> messages = await query.getAllSms;
    for (var message in messages) {
      if (message.address == "MobileMoney") {
        if (!mySmss.contains(message.body)) {
          mySmss.add(message.body);
        }
      }
    }
  }

  Future checkMtnBalance() async {
    fetchInbox();
    Get.defaultDialog(
        content: Column(
          children: [Text(mySmss.first)],
        ),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child:
              const Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    if (storage.read("username") != null) {
      setState(() {
        username = storage.read("username");
      });
    }
    fetchAllInstalled();
    getAllTriggeredNotifications();
    getAllUnReadNotifications();
    fetchCustomersWithBirthDays();
    getAllUnpaidDepositRequests();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      getAllTriggeredNotifications();
      getAllUnReadNotifications();
      getAllUnpaidDepositRequests();
      // fetchCustomersWithBirthDays();
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      for (var e in triggered) {
        unTriggerNotifications(e["id"]);
      }
    });
  }

  Future<void> openDialer() async {
    await UssdAdvanced.multisessionUssd(code: "*171#", subscriptionId: 1);
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const Points());
                },
                leading: Image.asset(
                  "assets/images/customer-loyalty.png",
                  width: 30,
                  height: 30,
                ),
                title: const Text('points'),
              ),
              ListTile(
                onTap: () {
                  openDialer();
                },
                leading: const Icon(Icons.phone),
                title: const Text('Dialer'),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const AllReportSummary());
                },
                leading: Image.asset(
                  "assets/images/notebook.png",
                  width: 30,
                  height: 30,
                ),
                title: const Text('Reports'),
              ),
              ListTile(
                onTap: () {
                  Get.defaultDialog(
                      buttonColor: primaryColor,
                      title: "Confirm Logout",
                      middleText: "Are you sure you want to logout?",
                      confirm: RawMaterialButton(
                          shape: const StadiumBorder(),
                          fillColor: primaryColor,
                          onPressed: () {
                            logoutUser();
                            Get.back();
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          )),
                      cancel: RawMaterialButton(
                          shape: const StadiumBorder(),
                          fillColor: primaryColor,
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          )));
                },
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
              ),
              const Spacer(),
              Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 14.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/png.png',
                  width: 50,
                  height: 50,
                ),
              ),
              const DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('App created by Havens Software Development'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("${username.toString().capitalize}"),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const AllPendingDepositRequests());
                  },
                  child: menuWidget(
                    title: 'Requests',
                    imagePath: 'assets/images/request-for-proposal.png',
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const AllPendingPayments());
                  },
                  child: menuWidget(
                    title: 'Payments',
                    imagePath: 'assets/images/cashless-payment.png',
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const AllUnPaidRequests());
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: badges.Badge(
                            badgeContent: Text(
                                "${unPaidDepositRequests.length}",
                                style: const TextStyle(color: Colors.white)),
                            badgeAnimation:
                                const badges.BadgeAnimation.rotation(
                              animationDuration: Duration(seconds: 1),
                              colorChangeAnimationDuration:
                                  Duration(seconds: 1),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                              colorChangeAnimationCurve: Curves.easeInCubic,
                            ),
                            child: menuWidget(
                              title: 'Unpaid',
                              imagePath: 'assets/images/cashless-payment.png',
                            )),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const AddToMyAccount());
                  },
                  child: menuWidget(
                    title: 'Link Bank',
                    imagePath: 'assets/images/bank-account.png',
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const MyBankAccounts());
                  },
                  child: menuWidget(
                    title: 'Bank Accounts',
                    imagePath: 'assets/images/bank.png',
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const MyAgents());
                  },
                  child: menuWidget(
                    title: 'Users',
                    imagePath: 'assets/images/group.png',
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const SelectSms());
                  },
                  child: menuWidget(
                    title: 'SMS',
                    imagePath: 'assets/images/sms.png',
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const AddNewUser());
                  },
                  child: menuWidget(
                    title: 'Register',
                    imagePath: 'assets/images/man.png',
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    showInstalled();
                  },
                  child: menuWidget(
                    title: 'Services',
                    imagePath: 'assets/images/commission (1).png',
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    checkMtnBalance();
                  },
                  child: menuWidget(
                    title: 'Balance',
                    imagePath: 'assets/images/balance.png',
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const Birthdays());
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: badges.Badge(
                            badgeContent: hasbdinfive
                                ? Text("${hasBirthDayInFive.length}",
                                    style: const TextStyle(color: Colors.white))
                                : hasbdintoday
                                    ? Text("${hasBirthDayToday.length}",
                                        style: const TextStyle(
                                            color: Colors.white))
                                    : const Text("0",
                                        style: TextStyle(color: Colors.white)),
                            badgeAnimation:
                                const badges.BadgeAnimation.rotation(
                              animationDuration: Duration(seconds: 1),
                              colorChangeAnimationDuration:
                                  Duration(seconds: 1),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                              colorChangeAnimationCurve: Curves.easeInCubic,
                            ),
                            child: menuWidget(
                              title: 'Birthdays',
                              imagePath: 'assets/images/cake.png',
                            )),
                      ),
                    ],
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const AllCustomers());
                  },
                  child: menuWidget(
                    title: 'Customers',
                    imagePath: 'assets/images/rating.png',
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

class menuWidget extends StatelessWidget {
  String title;
  String imagePath;

  menuWidget({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 70,
          height: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

//
