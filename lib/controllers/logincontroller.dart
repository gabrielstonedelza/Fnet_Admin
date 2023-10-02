import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/homepage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../screens/loginview.dart';
import '../screens/newhomepage.dart';
import '../static/app_colors.dart';

class LoginController extends GetxController {
  final client = http.Client();
  final storage = GetStorage();
  bool isLoggingIn = false;
  bool isUser = false;
  late String myToken = "";
  late String agentUsername = "";

  String errorMessage = "";
  bool isLoading = false;

  loginUser(String username, String password) async {
    const loginUrl = "https://fnetghana.xyz/auth/token/login/";
    final myLink = Uri.parse(loginUrl);
    http.Response response = await client.post(myLink,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": username, "password": password});

    if (response.statusCode == 200) {
      final resBody = response.body;
      var jsonData = jsonDecode(resBody);
      var userToken = jsonData['auth_token'];
      agentUsername = username;
      storage.write("token", userToken);
      storage.write("username", username);
      isLoggingIn = false;
      isUser = true;
      update();
      Get.offAll(() => const NewHomePage());
    } else {
      Get.snackbar("Sorry 😢", "invalid details",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: warning,
          colorText: defaultTextColor1);
      isLoggingIn = false;
      isUser = false;
      storage.remove("token");
      storage.remove("username");
    }
  }

  logoutUser(String token) async {
    storage.remove("token");
    storage.remove("username");

    Get.offAll(() => const LoginView());
    const logoutUrl = "https://www.fnetghana.xyz/auth/token/logout";
    final myLink = Uri.parse(logoutUrl);
    http.Response response = await http.post(myLink, headers: {
      'Accept': 'application/json',
      "Authorization": "Token $token"
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
}
