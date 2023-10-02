import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BankAccountsController extends GetxController {
  late List myBankAccounts = [];
  bool isLoading = true;

  Future<void> getAllMyBankAccounts(String token) async {
    const url = "https://fnetghana.xyz/get_my_user_accounts/";
    var link = Uri.parse(url);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      myBankAccounts.assignAll(jsonData);
      update();
      isLoading = false;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }
}
