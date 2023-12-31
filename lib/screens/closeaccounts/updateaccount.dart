import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';
import '../homepage.dart';
import '../newhomepage.dart';

class UpdateCloseAccount extends StatefulWidget {
  final mtn_cash;
  final express_cash;
  final ecobank_cash;
  final gtbank_cash;
  final calbank_cash;
  final fidelity_cash;
  final debit_cash;
  final over_cash;
  final shortage_cash;
  final cl1_cash;
  final cl2_cash;
  final cl3_cash;
  final cl4_cash;
  final cl5_cash;
  final cl6_cash;
  final cl7_cash;
  final cl8_cash;
  final cl9_cash;
  final cl10_cash;
  final user1;
  final user2;
  final user3;
  final user4;
  final user5;
  final user6;
  final user7;
  final user8;
  final user9;
  final user10;
  final credit1;
  final credit2;
  final credit3;
  final credit4;
  final credit5;
  final credit6;
  final credit7;
  final credit8;
  final credit9;
  final credit10;
  final acredit1;
  final acredit2;
  final acredit3;
  final acredit4;
  final acredit5;
  final acredit6;
  final acredit7;
  final acredit8;
  final acredit9;
  final acredit10;
  final cashleftamount1;
  final cashleftamount2;
  final cashleftamount3;
  final cashleftamount4;
  final cashleftamount5;
  final cashleftamount6;
  final cashleftamount7;
  final cashleftamount8;
  final cashleftamount9;
  final cashleftamount10;
  final total;
  final id;
  const UpdateCloseAccount({
    super.key,
    required this.cashleftamount1,
    required this.cashleftamount2,
    required this.cashleftamount3,
    required this.cashleftamount4,
    required this.cashleftamount5,
    required this.cashleftamount6,
    required this.cashleftamount7,
    required this.cashleftamount8,
    required this.cashleftamount9,
    required this.cashleftamount10,
    required this.credit1,
    required this.credit2,
    required this.credit3,
    required this.credit4,
    required this.credit5,
    required this.credit6,
    required this.credit7,
    required this.credit8,
    required this.credit9,
    required this.credit10,
    required this.acredit1,
    required this.acredit2,
    required this.acredit3,
    required this.acredit4,
    required this.acredit5,
    required this.acredit6,
    required this.acredit7,
    required this.acredit8,
    required this.acredit9,
    required this.acredit10,
    required this.mtn_cash,
    required this.express_cash,
    required this.ecobank_cash,
    required this.gtbank_cash,
    required this.calbank_cash,
    required this.fidelity_cash,
    required this.debit_cash,
    required this.over_cash,
    required this.shortage_cash,
    required this.cl1_cash,
    required this.cl2_cash,
    required this.cl3_cash,
    required this.cl4_cash,
    required this.cl5_cash,
    required this.cl6_cash,
    required this.cl8_cash,
    required this.cl7_cash,
    required this.cl9_cash,
    required this.cl10_cash,
    required this.user1,
    required this.user2,
    required this.user3,
    required this.user4,
    required this.user5,
    required this.user6,
    required this.user7,
    required this.user8,
    required this.user9,
    required this.user10,
    required this.total,
    required this.id,
  });

  @override
  State<UpdateCloseAccount> createState() => _UpdateCloseAccountState(
        cashleftamount1: this.cashleftamount1,
        cashleftamount2: this.cashleftamount2,
        cashleftamount3: this.cashleftamount3,
        cashleftamount4: this.cashleftamount4,
        cashleftamount5: this.cashleftamount5,
        cashleftamount6: this.cashleftamount6,
        cashleftamount7: this.cashleftamount7,
        cashleftamount8: this.cashleftamount8,
        cashleftamount9: this.cashleftamount9,
        cashleftamount10: this.cashleftamount10,
        credit1: this.credit1,
        credit2: this.credit2,
        credit3: this.credit3,
        credit4: this.credit4,
        credit5: this.credit5,
        credit6: this.credit6,
        credit7: this.credit7,
        credit8: this.credit8,
        credit9: this.credit9,
        credit10: this.credit10,
        acredit1: this.acredit1,
        acredit2: this.acredit2,
        acredit3: this.acredit3,
        acredit4: this.acredit4,
        acredit5: this.acredit5,
        acredit6: this.acredit6,
        acredit7: this.acredit7,
        acredit8: this.acredit8,
        acredit9: this.acredit9,
        acredit10: this.acredit10,
        mtn_cash: this.mtn_cash,
        express_cash: this.express_cash,
        ecobank_cash: this.ecobank_cash,
        gtbank_cash: this.gtbank_cash,
        calbank_cash: this.calbank_cash,
        fidelity_cash: this.fidelity_cash,
        debit_cash: this.debit_cash,
        over_cash: this.over_cash,
        shortage_cash: this.shortage_cash,
        cl1_cash: this.cl1_cash,
        cl2_cash: this.cl2_cash,
        cl3_cash: this.cl3_cash,
        cl4_cash: this.cl4_cash,
        cl5_cash: this.cl5_cash,
        cl6_cash: this.cl6_cash,
        cl7_cash: this.cl7_cash,
        cl8_cash: this.cl8_cash,
        cl9_cash: this.cl9_cash,
        cl10_cash: this.cl10_cash,
        user1: this.user1,
        user2: this.user2,
        user3: this.user3,
        user4: this.user4,
        user5: this.user5,
        user6: this.user6,
        user7: this.user7,
        user8: this.user8,
        user9: this.user9,
        user10: this.user10,
        total: this.total,
        id: this.id,
      );
}

class _UpdateCloseAccountState extends State<UpdateCloseAccount> {
  final cashleftamount1;
  final cashleftamount2;
  final cashleftamount3;
  final cashleftamount4;
  final cashleftamount5;
  final cashleftamount6;
  final cashleftamount7;
  final cashleftamount8;
  final cashleftamount9;
  final cashleftamount10;
  final credit1;
  final credit2;
  final credit3;
  final credit4;
  final credit5;
  final credit6;
  final credit7;
  final credit8;
  final credit9;
  final credit10;
  final acredit1;
  final acredit2;
  final acredit3;
  final acredit4;
  final acredit5;
  final acredit6;
  final acredit7;
  final acredit8;
  final acredit9;
  final acredit10;
  final mtn_cash;
  final express_cash;
  final ecobank_cash;
  final gtbank_cash;
  final calbank_cash;
  final fidelity_cash;
  final debit_cash;
  final over_cash;
  final shortage_cash;
  final cl1_cash;
  final cl2_cash;
  final cl3_cash;
  final cl4_cash;
  final cl5_cash;
  final cl6_cash;
  final cl7_cash;
  final cl8_cash;
  final cl9_cash;
  final cl10_cash;
  final user1;
  final user2;
  final user3;
  final user4;
  final user5;
  final user6;
  final user7;
  final user8;
  final user9;
  final user10;
  final total;
  final id;
  _UpdateCloseAccountState({
    required this.credit1,
    required this.credit2,
    required this.credit3,
    required this.credit4,
    required this.credit5,
    required this.credit6,
    required this.credit7,
    required this.credit8,
    required this.credit9,
    required this.credit10,
    required this.acredit1,
    required this.acredit2,
    required this.acredit3,
    required this.acredit4,
    required this.acredit5,
    required this.acredit6,
    required this.acredit7,
    required this.acredit8,
    required this.acredit9,
    required this.acredit10,
    required this.mtn_cash,
    required this.express_cash,
    required this.ecobank_cash,
    required this.gtbank_cash,
    required this.calbank_cash,
    required this.fidelity_cash,
    required this.debit_cash,
    required this.over_cash,
    required this.shortage_cash,
    required this.cl1_cash,
    required this.cl2_cash,
    required this.cl3_cash,
    required this.cl4_cash,
    required this.cl5_cash,
    required this.cl6_cash,
    required this.cl8_cash,
    required this.cl7_cash,
    required this.cl9_cash,
    required this.cl10_cash,
    required this.user1,
    required this.user2,
    required this.user3,
    required this.user4,
    required this.user5,
    required this.user6,
    required this.user7,
    required this.user8,
    required this.user9,
    required this.user10,
    required this.total,
    required this.id,
    required this.cashleftamount1,
    required this.cashleftamount2,
    required this.cashleftamount3,
    required this.cashleftamount4,
    required this.cashleftamount5,
    required this.cashleftamount6,
    required this.cashleftamount7,
    required this.cashleftamount8,
    required this.cashleftamount9,
    required this.cashleftamount10,
  });
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
  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
  }

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
  late final TextEditingController amountController;

  late final TextEditingController mtn;
  late final TextEditingController express;
  late final TextEditingController ecobank;
  late final TextEditingController gtbank;
  late final TextEditingController calbank;
  late final TextEditingController fidelity;
  late final TextEditingController debit;
  late final TextEditingController over;
  late final TextEditingController shortage;
  late final TextEditingController userOne;
  late final TextEditingController userTwo;
  late final TextEditingController userThree;
  late final TextEditingController userFour;
  late final TextEditingController userFive;
  late final TextEditingController userSix;
  late final TextEditingController userSeven;
  late final TextEditingController userEight;
  late final TextEditingController userNine;
  late final TextEditingController userTen;
  late final TextEditingController userToCreditOne;
  late final TextEditingController userToCreditTwo;
  late final TextEditingController userToCreditThree;
  late final TextEditingController userToCreditFour;
  late final TextEditingController userToCreditFive;
  late final TextEditingController userToCreditSix;
  late final TextEditingController userToCreditSeven;
  late final TextEditingController userToCreditEight;
  late final TextEditingController userToCreditNine;
  late final TextEditingController userToCreditTen;
  late final TextEditingController amountToCreditOne;
  late final TextEditingController amountToCreditTwo;
  late final TextEditingController amountToCreditThree;
  late final TextEditingController amountToCreditFour;
  late final TextEditingController amountToCreditFive;
  late final TextEditingController amountToCreditSix;
  late final TextEditingController amountToCreditSeven;
  late final TextEditingController amountToCreditEight;
  late final TextEditingController amountToCreditNine;
  late final TextEditingController amountToCreditTen;
  late final TextEditingController cashLeftAmountOne;
  late final TextEditingController cashLeftAmountTwo;
  late final TextEditingController cashLeftAmountThree;
  late final TextEditingController cashLeftAmountFour;
  late final TextEditingController cashLeftAmountFive;
  late final TextEditingController cashLeftAmountSix;
  late final TextEditingController cashLeftAmountSeven;
  late final TextEditingController cashLeftAmountEight;
  late final TextEditingController cashLeftAmountNine;
  late final TextEditingController cashLeftAmountTen;

  late final TextEditingController totalController;

  updateCloseAccount() async {
    final amountReceivedUrl =
        "https://fnetghana.xyz/update_account_closed_details/$id/";
    final myLink = Uri.parse(amountReceivedUrl);
    final res = await http.put(myLink, headers: {
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
      "user1": userOne.text.trim(),
      "user2": userTwo.text.trim(),
      "user3": userThree.text.trim(),
      "user4": userFour.text.trim(),
      "user5": userFive.text.trim(),
      "user6": userSix.text.trim(),
      "user7": userSeven.text.trim(),
      "user8": userEight.text.trim(),
      "user9": userNine.text.trim(),
      "user10": userTen.text.trim(),
      "total": totalController.text.trim(),
    });
    if (res.statusCode == 200) {
      setState(() {
        isPosting = false;
      });
      Get.snackbar("Congratulations", "Your account was updated",
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 10),
          backgroundColor: snackBackground);
      Get.offAll(() => const NewHomePage());
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      setState(() {
        uToken = storage.read("token");
      });
    }

    amountController = TextEditingController();
    mtn = TextEditingController(text: mtn_cash);
    express = TextEditingController(text: express_cash);
    ecobank = TextEditingController(text: ecobank_cash);
    gtbank = TextEditingController(text: gtbank_cash);
    calbank = TextEditingController(text: calbank_cash);
    fidelity = TextEditingController(text: fidelity_cash);
    debit = TextEditingController(text: debit_cash);
    over = TextEditingController(text: over_cash);
    shortage = TextEditingController(text: shortage_cash);
    userOne = TextEditingController(text: user1);
    userTwo = TextEditingController(text: user2);
    userThree = TextEditingController(text: user3);
    userFour = TextEditingController(text: user4);
    userFive = TextEditingController(text: user5);
    userSix = TextEditingController(text: user6);
    userSeven = TextEditingController(text: user7);
    userEight = TextEditingController(text: user8);
    userNine = TextEditingController(text: user9);
    userTen = TextEditingController(text: user10);
    userToCreditOne = TextEditingController(text: credit1);
    userToCreditTwo = TextEditingController(text: credit2);
    userToCreditThree = TextEditingController(text: credit3);
    userToCreditFour = TextEditingController(text: credit4);
    userToCreditFive = TextEditingController(text: credit5);
    userToCreditSix = TextEditingController(text: credit6);
    userToCreditSeven = TextEditingController(text: credit7);
    userToCreditEight = TextEditingController(text: credit8);
    userToCreditNine = TextEditingController(text: credit9);
    userToCreditTen = TextEditingController(text: credit10);
    amountToCreditOne = TextEditingController(text: acredit1);
    amountToCreditTwo = TextEditingController(text: acredit2);
    amountToCreditThree = TextEditingController(text: acredit3);
    amountToCreditFour = TextEditingController(text: acredit4);
    amountToCreditFive = TextEditingController(text: acredit5);
    amountToCreditSix = TextEditingController(text: acredit6);
    amountToCreditSeven = TextEditingController(text: acredit7);
    amountToCreditEight = TextEditingController(text: acredit8);
    amountToCreditNine = TextEditingController(text: acredit9);
    amountToCreditTen = TextEditingController(text: acredit10);
    cashLeftAmountOne = TextEditingController(text: cashleftamount1);
    cashLeftAmountTwo = TextEditingController(text: cashleftamount2);
    cashLeftAmountThree = TextEditingController(text: cashleftamount3);
    cashLeftAmountFour = TextEditingController(text: cashleftamount4);
    cashLeftAmountFive = TextEditingController(text: cashleftamount5);
    cashLeftAmountSix = TextEditingController(text: cashleftamount6);
    cashLeftAmountSeven = TextEditingController(text: cashleftamount7);
    cashLeftAmountEight = TextEditingController(text: cashleftamount8);
    cashLeftAmountNine = TextEditingController(text: cashleftamount9);
    cashLeftAmountTen = TextEditingController(text: cashleftamount10);
    totalController = TextEditingController(text: total);
    _currentSelectedCashLeftLocation1 = cl1_cash;
    _currentSelectedCashLeftLocation2 = cl2_cash;
    _currentSelectedCashLeftLocation3 = cl3_cash;
    _currentSelectedCashLeftLocation4 = cl4_cash;
    _currentSelectedCashLeftLocation5 = cl5_cash;
    _currentSelectedCashLeftLocation6 = cl6_cash;
    _currentSelectedCashLeftLocation7 = cl7_cash;
    _currentSelectedCashLeftLocation8 = cl8_cash;
    _currentSelectedCashLeftLocation9 = cl9_cash;
    _currentSelectedCashLeftLocation10 = cl10_cash;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    amountController.dispose();
    mtn.dispose();
    express.dispose();
    ecobank.dispose();
    gtbank.dispose();
    calbank.dispose();
    fidelity.dispose();
    debit.dispose();
    over.dispose();
    shortage.dispose();
    userOne.dispose();
    userTwo.dispose();
    userThree.dispose();
    userFour.dispose();
    userFive.dispose();
    userSix.dispose();
    userSeven.dispose();
    userEight.dispose();
    userNine.dispose();
    userTen.dispose();
    userToCreditOne.dispose();
    userToCreditTwo.dispose();
    userToCreditThree.dispose();
    userToCreditFour.dispose();
    userToCreditFive.dispose();
    userToCreditSix.dispose();
    userToCreditSeven.dispose();
    userToCreditEight.dispose();
    userToCreditNine.dispose();
    userToCreditTen.dispose();
    totalController.dispose();
    amountToCreditOne.dispose();
    amountToCreditTwo.dispose();
    amountToCreditThree.dispose();
    amountToCreditFour.dispose();
    amountToCreditFive.dispose();
    amountToCreditSix.dispose();
    amountToCreditSeven.dispose();
    amountToCreditEight.dispose();
    amountToCreditNine.dispose();
    amountToCreditTen.dispose();
    cashLeftAmountOne.dispose();
    cashLeftAmountTwo.dispose();
    cashLeftAmountThree.dispose();
    cashLeftAmountFour.dispose();
    cashLeftAmountFive.dispose();
    cashLeftAmountSix.dispose();
    cashLeftAmountSeven.dispose();
    cashLeftAmountEight.dispose();
    cashLeftAmountNine.dispose();
    cashLeftAmountTen.dispose();
    totalController.dispose();
    super.dispose();
  }

  // this is the process

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Close Account")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  mtn_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  express_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  ecobank_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  gtbank_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  calbank_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  fidelity_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  debit_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  shortage_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  over_cash != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation1 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user1 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userOne,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount1 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountOne,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation2 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user2 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userTwo,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount2 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountTwo,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation3 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user3 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userThree,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount3 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountThree,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation4 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user4 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userFour,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount4 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountFour,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation5 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user5 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userFive,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount5 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountFive,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation6 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user6 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userSix,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount6 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountSix,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation7 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user7 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userSeven,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount7 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountSeven,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation8 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user8 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userEight,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount8 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountEight,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation9 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user9 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userNine,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount9 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountNine,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  _currentSelectedCashLeftLocation10 != "Select cash left @"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
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
                        )
                      : Container(),
                  user10 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: userTen,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Name",
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
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter username";
                              }
                            },
                          ),
                        )
                      : Container(),
                  cashleftamount10 != "0.00"
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            controller: cashLeftAmountTen,
                            cursorColor: primaryColor,
                            cursorRadius: const Radius.elliptical(10, 10),
                            cursorWidth: 10,
                            decoration: InputDecoration(
                                labelText: "Amount",
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
                        )
                      : Container(),
                  // post payment
                  isPosting
                      ? const LoadingUi()
                      : RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              isPosting = true;
                            });
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              updateCloseAccount();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 8,
                          fillColor: primaryColor,
                          splashColor: defaultColor,
                          child: const Text(
                            "Update",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )
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
