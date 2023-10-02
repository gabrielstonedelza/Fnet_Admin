import 'dart:async';
import 'dart:convert';
import 'package:age_calculator/age_calculator.dart';
import 'package:badges/badges.dart' as badges;
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart' as mySms;
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:fnet_admin/controllers/customerscontroller.dart';
import 'package:fnet_admin/controllers/logincontroller.dart';
import 'package:fnet_admin/controllers/paymentscontroller.dart';
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
import 'package:provider/provider.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

import '../controllers/bankaccountscontroller.dart';
import '../controllers/closeaccountcontroller.dart';
import '../controllers/misccontroller.dart';
import '../controllers/notificationcontroller.dart';
import '../controllers/pointscontroller.dart';
import '../controllers/reportscontroller.dart';
import '../controllers/requestcontroller.dart';
import '../sendsms.dart';
import 'agents/allusers.dart';
import 'bankaccounts/getaccountsandpull.dart';
import 'bankaccounts/getaccountsandpush.dart';
import 'bankaccounts/mybankaccounts.dart';
import 'bankaccounts/registerbankaccounts.dart';
import 'birthdays.dart';
import 'closeaccounts/closeaccountsummary.dart';
import 'customers/allcustomers.dart';
import 'loginview.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  final LoginController controller = Get.find();
  final NotificationController notificationController = Get.find();
  final CustomersController customersController = Get.find();
  final RequestController requestController = Get.find();
  final MiscController miscController = Get.find();
  final PaymentController paymentController = Get.find();
  final ReportController reportController = Get.find();
  final PointsController pointsController = Get.find();
  final CloseAccountsController closeAccountsController = Get.find();
  final BankAccountsController bankAccountController = Get.find();
  final storage = GetStorage();
  late String uToken = "";
  late String username = "";

  late Timer _timer;

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
    scheduleTimers();
  }

  void scheduleTimers() {
    Timer.periodic(const Duration(hours: 3), (Timer timer) {
      notificationController.getAllTriggeredNotifications(uToken);
      notificationController.getAllUnReadNotifications(uToken);
      customersController.fetchCustomersWithBirthDays();
      customersController.getAllCustomers();
      requestController.getAllUnpaidDepositRequests();
      requestController.getAllPendingDeposits();
      requestController.getAllPendingRequestDeposits();
      reportController.fetchAllReports(uToken);
      pointsController.getAllAccountsWithPointsForToday(uToken);
      pointsController.getAllAccountsWithPointsForWeek(uToken);
      pointsController.getAllAccountsWithPointsForMonth(uToken);
      pointsController.getAllAccountsWithPoints(uToken);
      paymentController.getAllPendingPayments();
      paymentController.getAllPayments();
      closeAccountsController.getAllMyClosedAccounts(uToken);
      bankAccountController.getAllMyBankAccounts(uToken);
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      for (var e in notificationController.triggered) {
        notificationController.unTriggerNotifications(e["id"], uToken);
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
                  Get.to(() => const CloseAccountSummary());
                },
                leading: const Icon(Icons.upload),
                title: const Text('Accounts'),
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
                            controller.logoutUser(uToken);
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: badges.Badge(
                            badgeContent: GetBuilder<RequestController>(
                                builder: (rController) {
                              return Text(
                                  "${rController.allPendingRequests.length}",
                                  style: const TextStyle(color: Colors.white));
                            }),
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
                              title: 'Requests',
                              imagePath:
                                  'assets/images/request-for-proposal.png',
                            )),
                      ),
                    ],
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => const AllPendingPayments());
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: badges.Badge(
                            badgeContent: GetBuilder<PaymentController>(
                                builder: (pController) {
                              return Text(
                                  "${pController.pendingPayments.length}",
                                  style: const TextStyle(color: Colors.white));
                            }),
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
                              title: 'Payments',
                              imagePath: 'assets/images/cashless-payment.png',
                            )),
                      ),
                    ],
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
                            badgeContent: GetBuilder<RequestController>(
                                builder: (rController) {
                              return Text(
                                  "${rController.unPaidDepositRequests.length}",
                                  style: const TextStyle(color: Colors.white));
                            }),
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
                    Get.to(() => MyAgents());
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
                    miscController.showInstalled(context);
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
                    miscController.checkMtnBalance();
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
                            badgeContent: GetBuilder<CustomersController>(
                                builder: (cController) {
                              return cController.hasbdinfive
                                  ? Text(
                                      "${cController.hasBirthDayInFive.length}",
                                      style:
                                          const TextStyle(color: Colors.white))
                                  : cController.hasbdintoday
                                      ? Text(
                                          "${cController.hasBirthDayToday.length}",
                                          style: const TextStyle(
                                              color: Colors.white))
                                      : const Text("0",
                                          style:
                                              TextStyle(color: Colors.white));
                            }),
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
