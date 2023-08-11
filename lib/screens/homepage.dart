import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fnet_admin/controllers/logincontroller.dart';
import 'package:fnet_admin/screens/requestdeposits/allpendingrequest.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
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
  late Timer _timer;
  bool isLoading = true;

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
                onTap: () {},
                leading: Image.asset("assets/images/customer-loyalty.png",width:30,height: 30,),
                title: const Text('points'),
              ),

              ListTile(
                onTap: () {},
                leading: const Icon(Icons.phone),
                title: const Text('Dialer'),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset("assets/images/refer.png",width:30,height: 30,),
                title: const Text('Referrals'),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset("assets/images/earning.png",width:30,height: 30,),
                title: const Text('Earnings'),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset("assets/images/notebook.png",width:30,height: 30,),
                title: const Text('Reports'),
              ),
              ListTile(
                onTap: () {},
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
                      child: Text(
                          'App created by Havens Software Development'),
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
          title: Text(username),
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
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: GestureDetector(
                  onTap: (){
                    Get.to(() => const AllPendingDepositRequests());
                  },
                  child:  menuWidget(title: 'Request', imagePath: 'assets/images/request-for-proposal.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child: menuWidget(title: 'Add Accounts', imagePath: 'assets/images/saving.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'Payments', imagePath: 'assets/images/cashless-payment.png',),
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
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'Account', imagePath: 'assets/images/data-analysis.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){
                    Get.to(() => const AllCustomers());
                  },
                  child: menuWidget(title: 'Customers', imagePath: 'assets/images/rating.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'Users', imagePath: 'assets/images/group.png',),
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
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'SMS', imagePath: 'assets/images/sms.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child: menuWidget(title: 'Cus Requests', imagePath: 'assets/images/rating.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'Services', imagePath: 'assets/images/commission (1).png',),
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
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'Balance', imagePath: 'assets/images/balance.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child: menuWidget(title: 'Birthdays', imagePath: 'assets/images/cake.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'Register', imagePath: 'assets/images/man.png',),
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
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child:  menuWidget(title: 'Link Bank', imagePath: 'assets/images/bank-account.png',),
                )),
                Expanded(child: GestureDetector(
                  onTap: (){},
                  child: menuWidget(title: 'Bank Accounts', imagePath: 'assets/images/bank.png',),
                )),
                // Expanded(child: GestureDetector(
                //   onTap: (){},
                //   // child:  menuWidget(title: '', imagePath: '',),
                // )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
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
  menuWidget({
    super.key,required this.title,required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath,width: 70,height: 70,),
        const SizedBox(height: 10,),
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
  }
}
