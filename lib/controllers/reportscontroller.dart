import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {
  late List allReports = [];
  var items;
  bool isLoading = true;
  late List reports = [];
  late List reportDates = [];

  Future<void> fetchAllReports(String token) async {
    const url = "https://fnetghana.xyz/get_all_reports/";
    var myLink = Uri.parse(url);
    final response =
        await http.get(myLink, headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allReports = json.decode(jsonData);
      for (var i in allReports) {
        if (!reportDates
            .contains(i['date_reported'].toString().split("T").first)) {
          reportDates.add(i['date_reported'].toString().split("T").first);
        }
      }
      update();
    }
  }
}
