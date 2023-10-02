import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/reports/reportsummarydetail.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../static/app_colors.dart';
import '../../../widgets/loadingui.dart';

import '../../controllers/reportscontroller.dart';
import 'addnewreport.dart';

class AllReportSummary extends StatefulWidget {
  const AllReportSummary({Key? key}) : super(key: key);

  @override
  State<AllReportSummary> createState() => _AllReportSummaryState();
}

class _AllReportSummaryState extends State<AllReportSummary> {
  final ReportController controller = Get.find();
  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";
  var items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (storage.read("token") != null) {
      setState(() {
        uToken = storage.read("token");
      });
    }
    controller.fetchAllReports(uToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Report Summary"),
        ),
        body: GetBuilder<ReportController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.reportDates != null
                  ? controller.reportDates.length
                  : 0,
              itemBuilder: (context, i) {
                items = controller.reportDates[i];
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AllReportSummaryDetail(
                              date_reported: controller.reportDates[i]);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Card(
                          color: secondaryColor,
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // shadowColor: Colors.pink,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      items,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              });
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondaryColor,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Get.to(() => const AddNewReport());
          },
        ));
  }
}
