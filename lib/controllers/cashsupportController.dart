import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../sendsms.dart';
import '../static/app_colors.dart';

class CashSupportController extends GetxController {
  bool isLoading = true;

  late List customersCashSupport = [];
  late List customersCashSupportRequests = [];
  late List customersCashSupportPaid = [];
  late List customersRequestsToRedeemPoints = [];
  late List customersRedeemPoints = [];
  final SendSmsController sendSms = SendSmsController();
  late String customerPoints = "";

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getAllCustomersRedeemPoints() async {
    try {
      isLoading = true;

      const profileLink = "https://fnetghana.xyz/get_all_redeemed_points/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        customersRedeemPoints = jsonData;
        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getAllRequestsToRedeemPoints() async {
    try {
      isLoading = true;

      const profileLink =
          "https://fnetghana.xyz/get_all_customers_redeeming_requests/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        customersRequestsToRedeemPoints = jsonData;
        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getAllCashSupportRequests() async {
    try {
      isLoading = true;

      const profileLink =
          "https://fnetghana.xyz/get_all_requested_cash_support/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        customersCashSupportRequests = jsonData;
        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getAllCashSupport() async {
    try {
      isLoading = true;

      const profileLink = "https://fnetghana.xyz/get_all_cash_support/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        customersCashSupport = jsonData;
        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getAllCashSupportPaid(String phone) async {
    try {
      isLoading = true;

      final profileLink =
          "https://fnetghana.xyz/get_all_customers_cash_support_paid/$phone/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        customersCashSupportPaid = jsonData;

        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateRedeemRequest(String id, String phone, String name) async {
    final depositUrl =
        "https://fnetghana.xyz/update_customer_request_to_redeem_points/$id/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      "redeemed": "True",
    });
    if (res.statusCode == 200) {
      updateCustomerActivePoints(phone);
      String telnum1 = phone;
      telnum1 = telnum1.replaceFirst("0", '+233');
      sendSms.sendMySms(telnum1, "FNET",
          "Hello $name,your request to redeem your points has been approved.Please stand by, an agent will give you a call soon. ");
      // update();
    } else {
      Get.snackbar("Error", res.body.toString(),
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor);
    }
  }

  Future<void> updateCustomerActivePoints(String phone) async {
    final depositUrl =
        "https://fnetghana.xyz/update_customer_active_points/$phone/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {});
    if (res.statusCode == 200) {
      // String telnum1 = phone;
      // telnum1 = telnum1.replaceFirst("0", '+233');
      // sendSms.sendMySms(telnum1, "FNET",
      //     "Hello $customerName,your request to redeem your points has been approved.Please stand by, an agent will give you a call soon. ");
      // update();
    } else {
      Get.snackbar("Error", res.body.toString(),
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor);
    }
  }
}
