import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RequestController extends GetxController {
  late List allRequests = [];
  late List allPendingRequests = [];
  bool isLoading = true;
  late List unPaidDepositRequests = [];

  Future<void> getAllPendingDeposits() async {
    try {
      isLoading = true;
      const profileLink = "https://fnetghana.xyz/admin_get_all_bank_deposits/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        // "Authorization": "Token $uToken"
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allRequests.assignAll(jsonData);
        if (kDebugMode) {
          print(allRequests);
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

  Future<void> getAllUnpaidDepositRequests() async {
    const url = "https://fnetghana.xyz/get_agents_unpaid_deposits/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      var deData = json.decode(jsonData);
      unPaidDepositRequests.assignAll(deData);
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllPendingRequestDeposits() async {
    const profileLink =
        "https://fnetghana.xyz/admin_get_all_pending_bank_deposits/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      allPendingRequests.assignAll(jsonData);
      isLoading = false;
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }
}
