import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CloseAccountsController extends GetxController {
  bool isLoading = true;
  late List allClosedAccounts = [];
  late List allClosedAccountsDates = [];

  Future<void> getAllMyClosedAccounts(String token) async {
    try {
      isLoading = true;
      const profileLink = "https://fnetghana.xyz/get_my_closed_accounts/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allClosedAccounts.assignAll(jsonData);
        for (var i in allClosedAccounts) {
          if (!allClosedAccountsDates
              .contains(i['date_created'].toString().split("T").first)) {
            allClosedAccountsDates
                .add(i['date_created'].toString().split("T").first);
          }
        }
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
