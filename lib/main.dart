import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnet_admin/screens/homepage.dart';
import 'package:fnet_admin/screens/loginview.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:telephony/telephony.dart';

import 'controllers/accountscontroller.dart';
import 'controllers/logincontroller.dart';
import 'controllers/profilecontroller.dart';

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  Get.put(LoginController());
  Get.put(ProfileController());
  Get.put(AccountsController());
  // Get.put(BankAccountsController());
  // Get.put(NotificationController());
  // Get.put(RequestController());
  // Get.put(CustomersController());
  // Get.put(UsersController());
  // Get.put(PaymentController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String _message = "";
  final telephony = Telephony.instance;

  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late String authDevice = "";
  bool isAuthDevice = false;
  bool isLoading = false;

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
      Get.defaultDialog(
          content: Column(
            children: [Text(_message)],
          ),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child:
                const Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
          ));
    });
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }

    if (!mounted) return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
      setState(() {
        hasToken = true;
      });
    } else {
      setState(() {
        hasToken = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: defaultColor,
          )),
      home: hasToken ? const HomePage() : const LoginView(),
    );
  }
}
