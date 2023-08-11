import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController{
  final storage = GetStorage();

  bool isLoading = true;
  late String uToken = "";
  late List yourNotifications = [];
  late List notRead = [];
  late List triggered = [];
  late List unreadNotifications = [];
  late List triggeredNotifications = [];
  late List allNotifications = [];
  late List allNots = [];
  late Timer _timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      getAllTriggeredNotifications();
      getAllUnReadNotifications();
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      for (var e in triggered) {
        unTriggerNotifications(e["id"]);
      }
    });
  }


  Future<void>getAllTriggeredNotifications() async {
    const url = "https://fnetghana.xyz/get_triggered_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      triggeredNotifications = json.decode(jsonData);
      triggered.assignAll(triggeredNotifications);
    }
  }

  Future<void>getAllUnReadNotifications() async {
    try{
      isLoading = true;
      const url = "https://fnetghana.xyz/get_user_notifications/";
      var myLink = Uri.parse(url);
      final response =
      await http.get(myLink, headers: {"Authorization": "Token $uToken"});
      if (response.statusCode == 200) {
        final codeUnits = response.body.codeUnits;
        var jsonData = const Utf8Decoder().convert(codeUnits);
        yourNotifications = json.decode(jsonData);
        notRead.assignAll(yourNotifications);
        update();
      }
      else{
        if (kDebugMode) {
          print(response.body);
        }
      }
    }
    catch(e){}
    finally{
      isLoading = false;
    }

  }

  Future<void>getAllNotifications() async {
    try{
      isLoading = true;
      const url = "https://fnetghana.xyz/get_all_user_notifications/";
      var myLink = Uri.parse(url);
      final response =
      await http.get(myLink, headers: {"Authorization": "Token $uToken"});
      if (response.statusCode == 200) {
        final codeUnits = response.body.codeUnits;
        var jsonData = const Utf8Decoder().convert(codeUnits);
        allNotifications = json.decode(jsonData);
        allNots.assignAll(allNotifications);
        update();
      }
      else{
        if (kDebugMode) {
          print(response.body);
        }
      }
    }
    catch(e){}
    finally{
      isLoading = false;
    }


  }

  Future<void>unTriggerNotifications(int id) async {
    try{
      isLoading = true;
      final requestUrl = "https://fnetghana.xyz/read_notification/$id/";
      final myLink = Uri.parse(requestUrl);
      final response = await http.put(myLink, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'Accept': 'application/json',
        "Authorization": "Token $uToken"
      }, body: {
        "notification_trigger": "Not Triggered",
      });
      if (response.statusCode == 200) {
        update();
      }
    }
    catch(e){}
    finally{
      isLoading = false;
    }

  }
}