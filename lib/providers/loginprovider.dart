import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../screens/homepage.dart';
import '../static/app_colors.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  final client = http.Client();
  final storage = GetStorage();
  late final String _agentUsername = "";
  late final String _deToken = "";

  String get name => _agentUsername;
  _setUsername(String name) {
    name = _agentUsername;
    notifyListeners();
  }

  setIsLoading(bool isLoadingNow) {
    isLoadingNow = isLoading;
    notifyListeners();
  }

  setToken(String token) {
    token = _deToken;
    notifyListeners();
  }

  Future<void> loginUser(String username, String password) async {
    const loginUrl = "https://fnetghana.xyz/auth/token/login/";
    final myLink = Uri.parse(loginUrl);
    http.Response response = await client.post(myLink,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": username, "password": password});

    if (response.statusCode == 200) {
      final resBody = response.body;
      var jsonData = jsonDecode(resBody);
      var userToken = jsonData['auth_token'];
      _setUsername(username);
      setToken(userToken);
      setIsLoading(false);
      notifyListeners();
      storage.write("token", userToken);
      storage.write("username", username);
      Get.offAll(() => const HomePage());
    } else {
      setIsLoading(false);
      notifyListeners();
      Get.snackbar("Sorry 😢", "invalid details",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: warning,
          colorText: defaultTextColor1);
      storage.remove("token");
      storage.remove("username");
    }
  }
}
