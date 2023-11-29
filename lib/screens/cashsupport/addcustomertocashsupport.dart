import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/newhomepage.dart';

import 'package:get_storage/get_storage.dart';
import "package:get/get.dart";

import 'package:http/http.dart' as http;

import '../../sendsms.dart';
import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';

class AddCustomerToCashSupport extends StatefulWidget {
  final id;
  final phone;
  final name;
  final amount;
  const AddCustomerToCashSupport(
      {super.key,
      required this.id,
      required this.phone,
      required this.name,
      required this.amount});

  @override
  State<AddCustomerToCashSupport> createState() =>
      _AddCustomerToCashSupportState(
          id: this.id, phone: this.phone, name: this.name, amount: this.amount);
}

class _AddCustomerToCashSupportState extends State<AddCustomerToCashSupport> {
  final id;
  final phone;
  final name;
  final amount;
  _AddCustomerToCashSupportState(
      {required this.id,
      required this.phone,
      required this.name,
      required this.amount});
  final storage = GetStorage();
  late final TextEditingController _amountController;
  late final TextEditingController _interestController;
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _interestFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isPosting = false;
  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
  }

  final SendSmsController sendSms = SendSmsController();

  Future<void> addToCashSupport() async {
    const depositUrl = "https://fnetghana.xyz/add_customer_to_cash_support/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      "customer_name": name,
      "customer_phone": phone,
      "amount": _amountController.text,
      "interest": _interestController.text,
    });
    if (res.statusCode == 201) {
      updateCashSupportRequest();
      Get.snackbar("Congratulations",
          "Customer has been granted cash support worth the amount ${_amountController.text}.",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: snackColor);
      String telnum1 = phone;
      telnum1 = telnum1.replaceFirst("0", '+233');
      sendSms.sendMySms(telnum1, "FNET",
          "Hello $name,your cash support request of ${_amountController.text} has been granted.");
      Get.offAll(() => const NewHomePage());
    } else {
      Get.snackbar("Error", res.body.toString(),
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor);
    }
  }

  Future<void> updateCashSupportRequest() async {
    final depositUrl = "https://fnetghana.xyz/update_request_cash_support/$id/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      "status": "Approved",
    });
    if (res.statusCode == 200) {
    } else {
      Get.snackbar("Error", res.body.toString(),
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor);
    }
  }

  @override
  void initState() {
    super.initState();
    _interestController = TextEditingController();
    _amountController = TextEditingController(text: amount);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to Cash Support",
            style: TextStyle(color: defaultTextColor1)),
        backgroundColor: defaultColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                      decoration: InputDecoration(
                          labelText: "Amount",
                          labelStyle: const TextStyle(color: defaultTextColor2),
                          focusColor: defaultTextColor2,
                          fillColor: defaultTextColor2,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultTextColor2, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      // cursorColor: Colors.black,
                      // style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter phone";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: _interestController,
                      focusNode: _interestFocusNode,
                      decoration: InputDecoration(
                          labelText: "Interest",
                          labelStyle: const TextStyle(color: defaultTextColor2),
                          focusColor: defaultTextColor2,
                          fillColor: defaultTextColor2,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultTextColor2, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      // cursorColor: Colors.black,
                      // style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  isPosting
                      ? const LoadingUi()
                      : RawMaterialButton(
                          onPressed: () {
                            _startPosting();
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              addToCashSupport();
                            }
                          },
                          // child: const Text("Send"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 8,
                          fillColor: primaryColor,
                          splashColor: defaultColor,
                          child: const Text(
                            "Send",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
