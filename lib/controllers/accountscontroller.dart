import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../static/app_colors.dart';

class AccountsController extends GetxController {
  late List accountsStarted = [];
  late List pointsForTheWeek = [];
  late List pointsForTheMonth = [];
  late List pointsToday = [];
  late List allPoints = [];
  late List allMyAgents = [];
  late List agentUsernames = [];
  late List allBlockedUsers = [];
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

    getAllMyAgents();
    fetchBlockedAgents();
  }

  Future<void> getAllMyAgents() async {
    try {
      isLoading = true;
      const allUsers = "https://fnetghana.xyz/all_agents/";
      var link = Uri.parse(allUsers);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allMyAgents.assignAll(jsonData);
        for (var i in allMyAgents) {
          if (!agentUsernames.contains(i['username'])) {
            agentUsernames.add(i['username']);
          }
        }
        update();
      }
    } catch (e) {
      // Get.snackbar("Sorry",
      //     "something happened or please check your internet connection",
      //     snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchBlockedAgents() async {
    try {
      isLoading = true;
      const url = "https://fnetghana.xyz/get_all_blocked_users/";
      var myLink = Uri.parse(url);
      final response = await http.get(myLink, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        // "Authorization": "Token $uToken"
      });

      if (response.statusCode == 200) {
        final codeUnits = response.body.codeUnits;
        var jsonData = const Utf8Decoder().convert(codeUnits);
        allBlockedUsers = json.decode(jsonData);
        update();
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
    }
  }

  addToBlockedList(String userId, String email, String username, String phone,
      String fullName) async {
    final depositUrl = "https://fnetghana.xyz/update_blocked/$userId/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    }, body: {
      "user_blocked": "True",
      "email": email,
      "username": username,
      "phone": phone,
      "full_name": fullName,
    });
    if (res.statusCode == 201) {
      getAllMyAgents();
      Get.snackbar("Success", "blocking agent",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: snackBackground);
    } else {
      if (kDebugMode) {
        print(res.body);
      }
    }
  }

  removeFromBlockedList(String userId, String email, String username,
      String phone, String fullName) async {
    final depositUrl = "https://fnetghana.xyz/update_blocked/$userId/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    }, body: {
      "user_blocked": "False",
      "email": email,
      "username": username,
      "phone": phone,
      "full_name": fullName,
    });
    if (res.statusCode == 201) {
      getAllMyAgents();
      Get.snackbar("Success", "agent is removed from block lists",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: snackBackground);
    } else {
      if (kDebugMode) {
        print(res.body);
      }
    }
  }
}
