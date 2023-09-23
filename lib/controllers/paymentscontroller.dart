import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PaymentController extends GetxController {
  late List allPayments = [];
  late List pendingPayments = [];
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

    getAllPendingPayments();
    getAllPayments();
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   getAllPendingPayments();
    //   getAllPayments();
    // });
  }

  Future<void> getAllPendingPayments() async {
    try {
      isLoading = true;
      const profileLink =
          "https://www.fnetghana.xyz/admin_get_all_pending_bank_payments/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        // "Authorization": "Token $uToken"
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        pendingPayments.assignAll(jsonData);

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

  Future<void> getAllPayments() async {
    try {
      isLoading = true;
      const profileLink =
          "https://www.fnetghana.xyz/admin_get_all_bank_payments/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        // "Authorization": "Token $uToken"
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allPayments.assignAll(jsonData);

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
