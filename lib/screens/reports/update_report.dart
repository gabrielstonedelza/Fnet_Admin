import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../homepage.dart';
import '../newhomepage.dart';

class UpdateReport extends StatefulWidget {
  final report;
  final user;
  final id;
  const UpdateReport(
      {Key? key, required this.report, required this.user, required this.id})
      : super(key: key);

  @override
  State<UpdateReport> createState() =>
      _UpdateReportState(report: this.report, user: this.user, id: this.id);
}

class _UpdateReportState extends State<UpdateReport> {
  final report;
  final user;
  final id;
  _UpdateReportState(
      {required this.report, required this.user, required this.id});
  late final TextEditingController titleController = TextEditingController();
  late final TextEditingController reportController;

  late String uToken = "";
  final storage = GetStorage();
  late String username = "";
  bool isPosting = false;

  final _formKey = GlobalKey<FormState>();
  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      isPosting = false;
    });
  }

  updateReport() async {
    final registerUrl = "https://fnetghana.xyz/update_report/$id/";
    final myLink = Uri.parse(registerUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    }, body: {
      "user": user,
      "report": reportController.text,
    });
    if (res.statusCode == 200) {
      Get.snackbar("Congratulations", "report updated successfully",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.TOP,
          backgroundColor: snackColor);
      Get.offAll(() => const NewHomePage());
    } else {
      if (kDebugMode) {
        print(res.body);
      }
      Get.snackbar("Error", "something went",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    if (storage.read("token") != null) {
      setState(() {
        uToken = storage.read("token");
      });
    }

    reportController = TextEditingController(text: report);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Update Report"),
              backgroundColor: primaryColor,
              actions: [
                isPosting
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: primaryColor,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _startPosting();
                          if (!_formKey.currentState!.validate()) {
                            Get.snackbar("Error",
                                "something went wrong. Please try again",
                                colorText: defaultTextColor1,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red);
                            return;
                          } else {
                            updateReport();
                          }
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            autofocus: true,
                            controller: reportController,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(5, 5),
                            cursorWidth: 5,
                            maxLines: 50,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              focusColor: primaryColor,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(12))
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter report";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
