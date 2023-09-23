import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BankAccountsController extends GetxController {
  late List myBankAccounts = [];
  bool isLoading = true;

  final storage = GetStorage();
  var username = "";
  String uToken = "";
  late Timer _timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    getAllBankAccounts();
  }

  Future<void> getAllBankAccounts() async {
    try {
      isLoading = true;
      const profileLink = "https://fnetghana.xyz/get_my_user_accounts/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        myBankAccounts.assignAll(jsonData);

        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
}
