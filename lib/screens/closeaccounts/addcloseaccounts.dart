import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';
import '../homepage.dart';

class AddCloseAccount extends StatefulWidget {
  const AddCloseAccount({super.key});

  @override
  State<AddCloseAccount> createState() => _AddCloseAccountState();
}

class _AddCloseAccountState extends State<AddCloseAccount> {
  late String uToken = "";
  final storage = GetStorage();
  bool isLoading = true;
  bool isUploading = false;

  final _formKey = GlobalKey<FormState>();
  List cashLeftAtLocations = [
    "Select cash left @",
    "HEAD OFFICE",
    "DVLA BRANCH",
    "KEJETIA BRANCH",
    "MELCOM SANTASI",
    "MELCOM SUAME",
    "MELCOM TANOSO"
  ];

  bool isPosting = false;
  var _currentSelectedCashLeftLocation1 = "Select cash left @";
  var _currentSelectedCashLeftLocation2 = "Select cash left @";
  var _currentSelectedCashLeftLocation3 = "Select cash left @";
  var _currentSelectedCashLeftLocation4 = "Select cash left @";
  var _currentSelectedCashLeftLocation5 = "Select cash left @";
  var _currentSelectedCashLeftLocation6 = "Select cash left @";
  var _currentSelectedCashLeftLocation7 = "Select cash left @";
  var _currentSelectedCashLeftLocation8 = "Select cash left @";
  var _currentSelectedCashLeftLocation9 = "Select cash left @";
  var _currentSelectedCashLeftLocation10 = "Select cash left @";
  late final TextEditingController totalController;
  late final TextEditingController user1;
  late final TextEditingController mtn;
  late final TextEditingController express;
  late final TextEditingController ecobank;
  late final TextEditingController gtbank;
  late final TextEditingController calbank;
  late final TextEditingController fidelity;
  late final TextEditingController debit;
  late final TextEditingController over;
  late final TextEditingController shortage;
  late final TextEditingController user2;
  late final TextEditingController user3;
  late final TextEditingController user4;
  late final TextEditingController user5;
  late final TextEditingController user6;
  late final TextEditingController user7;
  late final TextEditingController user8;
  late final TextEditingController user9;
  late final TextEditingController user10;

  late final TextEditingController userToCredit1;
  late final TextEditingController userToCredit2;
  late final TextEditingController userToCredit3;
  late final TextEditingController userToCredit4;
  late final TextEditingController userToCredit5;
  late final TextEditingController userToCredit6;
  late final TextEditingController userToCredit7;
  late final TextEditingController userToCredit8;
  late final TextEditingController userToCredit9;
  late final TextEditingController userToCredit10;

  late final TextEditingController amountToCredit1;
  late final TextEditingController amountToCredit2;
  late final TextEditingController amountToCredit3;
  late final TextEditingController amountToCredit4;
  late final TextEditingController amountToCredit5;
  late final TextEditingController amountToCredit6;
  late final TextEditingController amountToCredit7;
  late final TextEditingController amountToCredit8;
  late final TextEditingController amountToCredit9;
  late final TextEditingController amountToCredit10;

  bool addedForm1 = false;
  bool addedForm2 = false;
  bool addedForm3 = false;
  bool addedForm4 = false;
  bool addedForm5 = false;
  bool addedForm6 = false;
  bool addedForm7 = false;
  bool addedForm8 = false;
  bool addedForm9 = false;
  bool addedForm10 = false;

  // for creditors

  bool addedCredit1 = false;
  bool addedCredit2 = false;
  bool addedCredit3 = false;
  bool addedCredit4 = false;
  bool addedCredit5 = false;
  bool addedCredit6 = false;
  bool addedCredit7 = false;
  bool addedCredit8 = false;
  bool addedCredit9 = false;
  bool addedCredit10 = false;

  late final TextEditingController numOfFormsController;
  late final TextEditingController numOfCreditController;
  bool isAmountSelectedAndNumOfFormsProvided = false;
  bool isAmountSelectedAndNumOfCreditProvided = false;
  int numberOfForms = 10;
  int numberOfCredit = 10;
  bool numberOfFormsProvided = false;
  bool numberOfCreditProvided = false;
  double myTotal = 0.00;
  double myMtn = 0.00;
  double myExpress = 0.00;
  double myEcobnak = 0.00;
  double myGtbank = 0.00;
  double myCalbank = 0.00;
  double myFidelity = 0.00;
  double myDebit = 0.00;
  double myShortage = 0.00;
  double myOver = 0.00;

  void showAndEnterFormNumber() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        reverse: true,
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                  child: Text("Enter number of fields needed for cash left at",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10, left: 10.0, right: 10),
                child: TextFormField(
                  controller: numOfFormsController,
                  cursorColor: primaryColor,
                  cursorRadius: const Radius.elliptical(10, 10),
                  cursorWidth: 10,
                  decoration: InputDecoration(
                      labelText: "Number of forms",
                      labelStyle: const TextStyle(color: secondaryColor),
                      focusColor: primaryColor,
                      fillColor: primaryColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                  keyboardType: TextInputType.number,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (numOfFormsController.text != "") {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (int.parse(numOfFormsController.text.trim()) >
                        numberOfForms) {
                      Get.snackbar("Sorry", "cannot be greater than 10",
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.red);
                    } else {
                      setState(() {
                        numberOfFormsProvided = true;
                        numberOfForms =
                            int.parse(numOfFormsController.text.trim());
                        isAmountSelectedAndNumOfFormsProvided = true;
                      });
                      switch (int.parse(numOfFormsController.text.trim())) {
                        case 1:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = false;
                            addedForm3 = false;
                            addedForm4 = false;
                            addedForm5 = false;
                            addedForm6 = false;
                            addedForm7 = false;
                            addedForm8 = false;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 2:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = false;
                            addedForm4 = false;
                            addedForm5 = false;
                            addedForm6 = false;
                            addedForm7 = false;
                            addedForm8 = false;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 3:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = false;
                            addedForm5 = false;
                            addedForm6 = false;
                            addedForm7 = false;
                            addedForm8 = false;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 4:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = true;
                            addedForm5 = false;
                            addedForm6 = false;
                            addedForm7 = false;
                            addedForm8 = false;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 5:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = true;
                            addedForm5 = true;
                            addedForm6 = false;
                            addedForm7 = false;
                            addedForm8 = false;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 6:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = true;
                            addedForm5 = true;
                            addedForm6 = true;
                            addedForm7 = false;
                            addedForm8 = false;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 7:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = true;
                            addedForm5 = true;
                            addedForm6 = true;
                            addedForm7 = true;
                            addedForm8 = false;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 8:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = true;
                            addedForm5 = true;
                            addedForm6 = true;
                            addedForm7 = true;
                            addedForm8 = true;
                            addedForm9 = false;
                            addedForm10 = false;
                          });
                          break;
                        case 9:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = true;
                            addedForm5 = true;
                            addedForm6 = true;
                            addedForm7 = true;
                            addedForm8 = true;
                            addedForm9 = true;
                            addedForm10 = false;
                          });
                          break;
                        case 10:
                          setState(() {
                            addedForm1 = true;
                            addedForm2 = true;
                            addedForm3 = true;
                            addedForm4 = true;
                            addedForm5 = true;
                            addedForm6 = true;
                            addedForm7 = true;
                            addedForm8 = true;
                            addedForm9 = true;
                            addedForm10 = true;
                          });
                          break;
                      }
                      Navigator.pop(context);
                    }
                  } else {
                    setState(() {
                      numberOfFormsProvided = false;
                      isAmountSelectedAndNumOfFormsProvided = false;
                      numberOfForms = 0;
                    });
                    Get.snackbar("Sorry", "Please enter number of forms needed",
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red);
                  }
                },
                child: const Text("Add Forms"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showAndEnterNumberForCredit() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        reverse: true,
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                  child: Text("Enter number of fields needed to credit",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10, left: 10.0, right: 10),
                child: TextFormField(
                  controller: numOfCreditController,
                  cursorColor: primaryColor,
                  cursorRadius: const Radius.elliptical(10, 10),
                  cursorWidth: 10,
                  decoration: InputDecoration(
                      labelText: "Number of forms",
                      labelStyle: const TextStyle(color: secondaryColor),
                      focusColor: primaryColor,
                      fillColor: primaryColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                  keyboardType: TextInputType.number,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (numOfCreditController.text != "") {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (int.parse(numOfCreditController.text.trim()) >
                        numberOfForms) {
                      Get.snackbar("Sorry", "cannot be greater than 10",
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.red);
                    } else {
                      setState(() {
                        numberOfFormsProvided = true;
                        numberOfForms =
                            int.parse(numOfCreditController.text.trim());
                        isAmountSelectedAndNumOfFormsProvided = true;
                      });
                      switch (int.parse(numOfCreditController.text.trim())) {
                        case 1:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = false;
                            addedCredit3 = false;
                            addedCredit4 = false;
                            addedCredit5 = false;
                            addedCredit6 = false;
                            addedCredit7 = false;
                            addedCredit8 = false;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 2:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = false;
                            addedCredit4 = false;
                            addedCredit5 = false;
                            addedCredit6 = false;
                            addedCredit7 = false;
                            addedCredit8 = false;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 3:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = false;
                            addedCredit5 = false;
                            addedCredit6 = false;
                            addedCredit7 = false;
                            addedCredit8 = false;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 4:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = true;
                            addedCredit5 = false;
                            addedCredit6 = false;
                            addedCredit7 = false;
                            addedCredit8 = false;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 5:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = true;
                            addedCredit5 = true;
                            addedCredit6 = false;
                            addedCredit7 = false;
                            addedCredit8 = false;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 6:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = true;
                            addedCredit5 = true;
                            addedCredit6 = true;
                            addedCredit7 = false;
                            addedCredit8 = false;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 7:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = true;
                            addedCredit5 = true;
                            addedCredit6 = true;
                            addedCredit7 = true;
                            addedCredit8 = false;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 8:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = true;
                            addedCredit5 = true;
                            addedCredit6 = true;
                            addedCredit7 = true;
                            addedCredit8 = true;
                            addedCredit9 = false;
                            addedCredit10 = false;
                          });
                          break;
                        case 9:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = true;
                            addedCredit5 = true;
                            addedCredit6 = true;
                            addedCredit7 = true;
                            addedCredit8 = true;
                            addedCredit9 = true;
                            addedCredit10 = false;
                          });
                          break;
                        case 10:
                          setState(() {
                            addedCredit1 = true;
                            addedCredit2 = true;
                            addedCredit3 = true;
                            addedCredit4 = true;
                            addedCredit5 = true;
                            addedCredit6 = true;
                            addedCredit7 = true;
                            addedCredit8 = true;
                            addedCredit9 = true;
                            addedCredit10 = true;
                          });
                          break;
                      }
                      Navigator.pop(context);
                    }
                  } else {
                    setState(() {
                      numberOfCreditProvided = false;
                      isAmountSelectedAndNumOfCreditProvided = false;
                      numberOfCredit = 0;
                    });
                    Get.snackbar("Sorry", "Please enter number of forms needed",
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red);
                  }
                },
                child: const Text("Add Forms"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
  }

  addAccountClose() async {
    const amountReceivedUrl = "https://fnetghana.xyz/close_accounts/";
    final myLink = Uri.parse(amountReceivedUrl);
    final res = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    }, body: {
      "mtn": mtn.text.trim(),
      "express": express.text.trim(),
      "ecobank": ecobank.text.trim(),
      "gtbank": gtbank.text.trim(),
      "calbank": calbank.text.trim(),
      "fidelity": fidelity.text.trim(),
      "debit": debit.text.trim(),
      "over": over.text.trim(),
      "shortage": shortage.text.trim(),
      "cash_left_at1": _currentSelectedCashLeftLocation1,
      "cash_left_at2": _currentSelectedCashLeftLocation2,
      "cash_left_at3": _currentSelectedCashLeftLocation3,
      "cash_left_at4": _currentSelectedCashLeftLocation4,
      "cash_left_at5": _currentSelectedCashLeftLocation5,
      "cash_left_at6": _currentSelectedCashLeftLocation6,
      "cash_left_at7": _currentSelectedCashLeftLocation7,
      "cash_left_at8": _currentSelectedCashLeftLocation8,
      "cash_left_at9": _currentSelectedCashLeftLocation9,
      "cash_left_at10": _currentSelectedCashLeftLocation10,
      "user1": user1.text.trim(),
      "user2": user2.text.trim(),
      "user3": user3.text.trim(),
      "user4": user4.text.trim(),
      "user5": user5.text.trim(),
      "user6": user6.text.trim(),
      "user7": user7.text.trim(),
      "user8": user8.text.trim(),
      "user9": user9.text.trim(),
      "user10": user10.text.trim(),
      "user_to_credit1": userToCredit1.text.trim(),
      "user_to_credit2": userToCredit2.text.trim(),
      "user_to_credit3": userToCredit3.text.trim(),
      "user_to_credit4": userToCredit4.text.trim(),
      "user_to_credit5": userToCredit5.text.trim(),
      "user_to_credit6": userToCredit6.text.trim(),
      "user_to_credit7": userToCredit7.text.trim(),
      "user_to_credit8": userToCredit8.text.trim(),
      "user_to_credit9": userToCredit9.text.trim(),
      "user_to_credit10": userToCredit10.text.trim(),
      "amount_to_credit1": amountToCredit1.text.trim(),
      "amount_to_credit2": amountToCredit2.text.trim(),
      "amount_to_credit3": amountToCredit3.text.trim(),
      "amount_to_credit4": amountToCredit4.text.trim(),
      "amount_to_credit5": amountToCredit5.text.trim(),
      "amount_to_credit6": amountToCredit6.text.trim(),
      "amount_to_credit7": amountToCredit7.text.trim(),
      "amount_to_credit8": amountToCredit8.text.trim(),
      "amount_to_credit9": amountToCredit9.text.trim(),
      "amount_to_credit10": amountToCredit10.text.trim(),
      "total": myTotal.toString(),
    });
    if (res.statusCode == 201) {
      Get.snackbar("Congratulations", "Your account was closed successfully",
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 10),
          backgroundColor: snackBackground);
      Get.offAll(() => const HomePage());
    } else {
      if (kDebugMode) {
        print(res.body);
      }
      Get.snackbar("Error", "something went wrong",
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red);
    }
  }

  double sumTotal = 0.00;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      setState(() {
        uToken = storage.read("token");
      });
    }

    numOfFormsController = TextEditingController();
    totalController = TextEditingController();
    mtn = TextEditingController(text: "0.00");
    express = TextEditingController(text: "0.00");
    ecobank = TextEditingController(text: "0.00");
    gtbank = TextEditingController(text: "0.00");
    calbank = TextEditingController(text: "0.00");
    fidelity = TextEditingController(text: "0.00");
    debit = TextEditingController(text: "0.00");
    over = TextEditingController(text: "0.00");
    shortage = TextEditingController(text: "0.00");
    numOfCreditController = TextEditingController();
    user1 = TextEditingController();
    user2 = TextEditingController();
    user3 = TextEditingController();
    user4 = TextEditingController();
    user5 = TextEditingController();
    user6 = TextEditingController();
    user7 = TextEditingController();
    user8 = TextEditingController();
    user9 = TextEditingController();
    user10 = TextEditingController();

    userToCredit1 = TextEditingController();
    userToCredit2 = TextEditingController();
    userToCredit3 = TextEditingController();
    userToCredit4 = TextEditingController();
    userToCredit5 = TextEditingController();
    userToCredit6 = TextEditingController();
    userToCredit7 = TextEditingController();
    userToCredit8 = TextEditingController();
    userToCredit9 = TextEditingController();
    userToCredit10 = TextEditingController();
    amountToCredit1 = TextEditingController();
    amountToCredit2 = TextEditingController();
    amountToCredit3 = TextEditingController();
    amountToCredit4 = TextEditingController();
    amountToCredit5 = TextEditingController();
    amountToCredit6 = TextEditingController();
    amountToCredit7 = TextEditingController();
    amountToCredit8 = TextEditingController();
    amountToCredit9 = TextEditingController();
    amountToCredit10 = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    totalController.dispose();
    mtn.dispose();
    express.dispose();
    ecobank.dispose();
    gtbank.dispose();
    calbank.dispose();
    fidelity.dispose();
    debit.dispose();
    over.dispose();
    shortage.dispose();
    user1.dispose();
    user2.dispose();
    user3.dispose();
    user4.dispose();
    user5.dispose();
    user6.dispose();
    user7.dispose();
    user8.dispose();
    user9.dispose();
    user10.dispose();
    userToCredit1.dispose();
    userToCredit2.dispose();
    userToCredit3.dispose();
    userToCredit4.dispose();
    userToCredit5.dispose();
    userToCredit6.dispose();
    userToCredit7.dispose();
    userToCredit8.dispose();
    userToCredit9.dispose();
    userToCredit10.dispose();
    amountToCredit1.dispose();
    amountToCredit2.dispose();
    amountToCredit3.dispose();
    amountToCredit4.dispose();
    amountToCredit5.dispose();
    amountToCredit6.dispose();
    amountToCredit7.dispose();
    amountToCredit8.dispose();
    amountToCredit9.dispose();
    amountToCredit10.dispose();
    numOfCreditController.dispose();
    super.dispose();
  }

  // this is the process

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Close Account"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Row(
              children: [
                const Text("Total: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(sumTotal.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myMtn = 0.0;
                                });
                              } else {
                                setState(() {
                                  myMtn = double.parse(value);
                                  sumTotal = myMtn;
                                });
                              }
                            },
                            controller: mtn,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Mtn",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myExpress = 0.0;
                                });
                              } else {
                                setState(() {
                                  myExpress = double.parse(value) + myMtn;
                                  sumTotal = double.parse(value) + myMtn;
                                });
                              }
                            },
                            controller: express,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Express",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myEcobnak = 0.0;
                                });
                              } else {
                                setState(() {
                                  myEcobnak = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim());
                                  sumTotal = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim());
                                });
                              }
                            },
                            controller: ecobank,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Ecobank",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myGtbank = 0.0;
                                });
                              } else {
                                setState(() {
                                  myGtbank = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim());
                                  sumTotal = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim());
                                });
                              }
                            },
                            controller: gtbank,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "GT Bank",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myCalbank = 0.0;
                                });
                              } else {
                                setState(() {
                                  myCalbank = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim());
                                  sumTotal = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim());
                                });
                              }
                            },
                            controller: calbank,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Calbank",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myFidelity = 0.0;
                                });
                              } else {
                                setState(() {
                                  myFidelity = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim());
                                  sumTotal = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim());
                                });
                              }
                            },
                            controller: fidelity,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Fidelity",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myDebit = 0.0;
                                });
                              } else {
                                setState(() {
                                  myDebit = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim()) +
                                      double.parse(fidelity.text.trim());
                                  sumTotal = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim()) +
                                      double.parse(fidelity.text.trim());
                                });
                              }
                            },
                            controller: debit,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Debit",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myShortage = 0.0;
                                });
                              } else {
                                setState(() {
                                  myShortage = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim()) +
                                      double.parse(fidelity.text.trim()) +
                                      double.parse(debit.text.trim());
                                  sumTotal = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim()) +
                                      double.parse(fidelity.text.trim()) +
                                      double.parse(debit.text.trim());
                                });
                              }
                            },
                            controller: shortage,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Shortage",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  myOver = 0.0;
                                });
                              } else {
                                setState(() {
                                  myOver = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim()) +
                                      double.parse(fidelity.text.trim()) +
                                      double.parse(debit.text.trim()) +
                                      double.parse(shortage.text.trim());
                                  sumTotal = double.parse(value) +
                                      double.parse(mtn.text.trim()) +
                                      double.parse(express.text.trim()) +
                                      double.parse(ecobank.text.trim()) +
                                      double.parse(gtbank.text.trim()) +
                                      double.parse(calbank.text.trim()) +
                                      double.parse(fidelity.text.trim()) +
                                      double.parse(debit.text.trim()) +
                                      double.parse(shortage.text.trim());
                                });
                              }
                            },
                            controller: over,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Over",
                                labelStyle:
                                    const TextStyle(color: secondaryColor),
                                focusColor: primaryColor,
                                fillColor: primaryColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter amount";
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text("",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ))
                    ],
                  ),

                  // check and add cash left at forms
                  addedForm1
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation1(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation1,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user1,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm2
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation2(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation2,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user2,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm3
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation3(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation3,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user3,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm4
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation4(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation4,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user4,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm5
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation5(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation5,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user5,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm6
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation6(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation6,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user6,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm7
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation7(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation7,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user7,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm8
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation8(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation8,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user8,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm9
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation9(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation9,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user9,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedForm10
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: DropdownButton(
                                      hint: const Text("Select location"),
                                      isExpanded: true,
                                      underline: const SizedBox(),
                                      items: cashLeftAtLocations
                                          .map((dropDownStringItem) {
                                        return DropdownMenuItem(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        _onDropDownItemSelectedCashLeftLocation10(
                                            newValueSelected);
                                      },
                                      value: _currentSelectedCashLeftLocation10,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: user10,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  // creditors forms
                  addedCredit1
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit1,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit1,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit2
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit2,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit2,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit3
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit3,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit3,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit4
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit4,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit4,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit5
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit5,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit5,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit6
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit6,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit6,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit7
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit7,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit7,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit8
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit8,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit8,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit9
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit9,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit9,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  addedCredit10
                      ? SlideInUp(
                          animate: true,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: userToCredit10,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  controller: amountToCredit10,
                                  cursorColor: primaryColor,
                                  cursorRadius: const Radius.elliptical(10, 10),
                                  cursorWidth: 10,
                                  decoration: InputDecoration(
                                      labelText: "Amount",
                                      labelStyle: const TextStyle(
                                          color: secondaryColor),
                                      focusColor: primaryColor,
                                      fillColor: primaryColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  // creditors forms
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          showAndEnterFormNumber();
                        },
                        child: const Text("Add cash left @"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("|"),
                      TextButton(
                        onPressed: () {
                          showAndEnterNumberForCredit();
                        },
                        child: const Text("Credit User"),
                      ),
                    ],
                  ),
                  // post payment
                  isPosting
                      ? const LoadingUi()
                      : RawMaterialButton(
                          onPressed: () {
                            _startPosting();
                            myTotal = double.parse(over.text.trim()) +
                                double.parse(mtn.text.trim()) +
                                double.parse(express.text.trim()) +
                                double.parse(ecobank.text.trim()) +
                                double.parse(gtbank.text.trim()) +
                                double.parse(calbank.text.trim()) +
                                double.parse(fidelity.text.trim()) +
                                double.parse(debit.text.trim()) +
                                double.parse(shortage.text.trim());
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              addAccountClose();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 8,
                          fillColor: primaryColor,
                          splashColor: defaultColor,
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDropDownItemSelectedCashLeftLocation1(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation1 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation2(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation2 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation3(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation3 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation4(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation4 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation5(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation5 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation6(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation6 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation7(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation7 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation8(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation8 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation9(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation9 = newValueSelected;
    });
  }

  void _onDropDownItemSelectedCashLeftLocation10(newValueSelected) {
    setState(() {
      _currentSelectedCashLeftLocation10 = newValueSelected;
    });
  }
}
