import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AccountsController extends GetxController{
  late List accountsStarted = [];
  late List pointsForTheWeek = [];
  late List pointsForTheMonth = [];
  late List pointsToday = [];
  late List allPoints = [];
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
    getAllAccountsWithPointsForToday();
    getAllAccountsWithPointsForWeek();
    getAllAccountsWithPointsForMonth();
    getAllAccountsWithPoints();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getAllAccountsWithPointsForToday();
      getAllAccountsWithPointsForWeek();
      getAllAccountsWithPointsForMonth();
      getAllAccountsWithPoints();
    });
  }


  Future<void> getAllAccountsWithPointsForToday() async {
    try {
      isLoading = true;
      const profileLink = "https://fnetghana.xyz/get_account_number_points_today/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        pointsToday.assignAll(jsonData);

        update();
      }
      else{
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
  Future<void> getAllAccountsWithPointsForWeek() async {
    try {
      isLoading = true;
      const profileLink = "https://fnetghana.xyz/get_account_number_points_week/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        pointsForTheWeek.assignAll(jsonData);

        update();
      }
      else{
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
  Future<void> getAllAccountsWithPointsForMonth() async {
    try {
      isLoading = true;
      const profileLink = "https://fnetghana.xyz/get_account_number_points_month/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        pointsForTheMonth.assignAll(jsonData);

        update();
      }
      else{
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
  Future<void> getAllAccountsWithPoints() async {
    try {
      isLoading = true;
      const profileLink = "https://fnetghana.xyz/get_all_account_number_points/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        allPoints.assignAll(jsonData);
        update();
      }
      else{
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