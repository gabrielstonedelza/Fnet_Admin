import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PointsController extends GetxController {
  bool isLoading = true;
  late List pointsForToday = [];
  late List pointsForWeek = [];
  late List pointsForMonth = [];
  late List points = [];

  Future<void> getAllAccountsWithPointsForToday(String token) async {
    const profileLink =
        "https://fnetghana.xyz/get_account_number_points_today/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      pointsForToday.assignAll(jsonData);
      update();
      isLoading = false;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllAccountsWithPointsForWeek(String token) async {
    const myLink = "https://fnetghana.xyz/get_account_number_points_week/";
    var link = Uri.parse(myLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      pointsForWeek.assignAll(jsonData);
      // print(pointsForToday);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllAccountsWithPointsForMonth(String token) async {
    const profileLink =
        "https://fnetghana.xyz/get_account_number_points_month/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      pointsForMonth.assignAll(jsonData);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  Future<void> getAllAccountsWithPoints(String token) async {
    const profileLink = "https://fnetghana.xyz/get_all_account_number_points/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      points.assignAll(jsonData);
      update();
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }
}
