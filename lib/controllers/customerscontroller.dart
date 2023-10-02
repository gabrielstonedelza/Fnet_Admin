import 'dart:async';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../sendsms.dart';

class CustomersController extends GetxController {
  late List allCustomers = [];
  bool isLoading = true;
  final storage = GetStorage();
  bool hasAlreadySent = false;
  late List sentBirthdays = [];
  String smsSent = "No";
  late List hasBirthDayInFive = [];
  late List hasBirthDayToday = [];
  late List todaysBirthdayPhones = [];
  bool hasbdinfive = false;
  bool hasbdintoday = false;
  late int sentCount = 1;
  bool isFetching = true;
  late DateDuration duration;
  final SendSmsController sendSms = SendSmsController();

  Future<void> getAllCustomers() async {
    try {
      isLoading = true;
      const profileLink = "https://www.fnetghana.xyz/all_customers/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        // "Authorization": "Token $uToken"
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allCustomers.assignAll(jsonData);
        if (kDebugMode) {
          print(allCustomers);
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

  Future<void> fetchCustomersWithBirthDays() async {
    const url = "https://www.fnetghana.xyz/all_customers/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allCustomers = json.decode(jsonData);
      for (var i in allCustomers) {
        DateTime birthday = DateTime.parse(i['date_of_birth']);
        duration = AgeCalculator.timeToNextBirthday(birthday);
        if (duration.months == 0 && duration.days == 5) {
          hasBirthDayInFive.add(i['name']);
          hasbdinfive = true;
          if (storage.read("birthdaySent") != null &&
              storage.read("birthdaySent") == "Yes") {
            storage.remove("birthdaySent");
            storage.write("birthdaySent", smsSent);
          }
        }
        if (duration.months == 0 &&
            duration.days == 0 &&
            storage.read("birthdaySent") != null &&
            storage.read('birthdaySent') == "No") {
          if (duration.months == 0 && duration.days == 0) {
            hasbdintoday = true;
            hasBirthDayToday.add(i['name']);
            todaysBirthdayPhones.add(i['phone']);
            for (var b in todaysBirthdayPhones) {
              String birthdayNum = b;
              birthdayNum = birthdayNum.replaceFirst("0", '+233');
              sendSms.sendMySms(birthdayNum, "FNET",
                  "Hello, FNET ENTERPRISE is wishing you a happy birthday,may God grant all your heart desires,thank you.");
              sendSms.sendMySms(birthdayNum, "FNET",
                  "Download customer app from https://play.google.com/store/apps/details?id=com.fnettransaction.fnet_customer");
              sentBirthdays.add(b);
              smsSent = "Yes";
              storage.write("birthdaySent", smsSent);
            }
          }
        }
      }
    }
  }
}
