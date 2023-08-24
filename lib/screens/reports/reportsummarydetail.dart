import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/reports/update_report.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../static/app_colors.dart';
import '../../../widgets/loadingui.dart';

class AllReportSummaryDetail extends StatefulWidget {
  final date_reported;
  const AllReportSummaryDetail({Key? key, this.date_reported})
      : super(key: key);

  @override
  _AllReportSummaryDetailState createState() =>
      _AllReportSummaryDetailState(date_reported: this.date_reported);
}

class _AllReportSummaryDetailState extends State<AllReportSummaryDetail> {
  final date_reported;

  _AllReportSummaryDetailState({required this.date_reported});
  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  late List reports = [];
  bool isLoading = true;
  late var items;
  late List amounts = [];
  late List amountResults = [];
  late List reportDates = [];
  double sum = 0.0;

  Future<void> fetchAllReports() async {
    const url = "https://fnetghana.xyz/get_all_reports/";
    var myLink = Uri.parse(url);
    final response =
        await http.get(myLink, headers: {"Authorization": "Token $uToken"});

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      reports = json.decode(jsonData);
      for (var i in reports) {
        if (i['date_reported'].toString().split("T").first == date_reported) {
          reportDates.add(i);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (storage.read("token") != null) {
      setState(() {
        hasToken = true;
        uToken = storage.read("token");
      });
    }
    fetchAllReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports for $date_reported"),
      ),
      body: SafeArea(
          child: isLoading
              ? const LoadingUi()
              : ListView.builder(
                  itemCount: reportDates != null ? reportDates.length : 0,
                  itemBuilder: (context, i) {
                    items = reportDates[i];
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Card(
                            color: secondaryColor,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // shadowColor: Colors.pink,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, bottom: 18),
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => UpdateReport(
                                      report: reportDates[i]['report'],
                                      user: reportDates[i]['user'].toString(),
                                      id: reportDates[i]['id'].toString()));
                                },
                                title: buildRow("Agent: ", "get_username"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.0, bottom: 8),
                                      child: Text(
                                        "Report : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: defaultTextColor1),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8, bottom: 8),
                                      child: Text(items['report'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: defaultTextColor1)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Date : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            items['date_reported']
                                                .toString()
                                                .split("T")
                                                .first,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Time : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            items['time_reported']
                                                .toString()
                                                .split(".")
                                                .first,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  })),
    );
  }

  Padding buildRow(String mainTitle, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            items[subtitle].toString(),
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
