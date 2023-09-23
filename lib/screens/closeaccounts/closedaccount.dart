import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/closeaccounts/updateaccount.dart';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/closeaccountcontroller.dart';
import '../../static/app_colors.dart';
import '../../widgets/loadingui.dart';
import '../homepage.dart';

class CloseAccount extends StatefulWidget {
  final date_created;
  const CloseAccount({super.key, required this.date_created});

  @override
  State<CloseAccount> createState() =>
      _CloseAccountState(date_created: this.date_created);
}

class _CloseAccountState extends State<CloseAccount> {
  final date_created;
  _CloseAccountState({required this.date_created});
  final CloseAccountsController controller = Get.find();
  late String uToken = "";
  final storage = GetStorage();
  late List allClosedDates = [];
  bool isLoading = true;
  late List allClosedAccounts = [];
  var items;
  double sum = 0.0;

  Future<void> fetchClosedAccounts() async {
    const url = "https://fnetghana.xyz/get_my_closed_accounts/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    });

    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allClosedAccounts = json.decode(jsonData);
      for (var i in allClosedAccounts) {
        if (i['date_created'].toString().split("T").first == date_created) {
          allClosedDates.add(i);
        }
      }
      if (kDebugMode) {
        print(allClosedAccounts);
        print(response.body);
      }

      setState(() {
        isLoading = false;
      });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
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
    fetchClosedAccounts();
  }

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

  deleteAccount(String id) async {
    final url = "https://fnetghana.xyz/delete_account/$id/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 204) {
      setState(() {
        isPosting = false;
        isLoading = false;
      });
      fetchClosedAccounts();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Accounts for $date_created")),
        body: isLoading
            ? const LoadingUi()
            : ListView.builder(
                itemCount: allClosedDates != null ? allClosedDates.length : 0,
                itemBuilder: (context, index) {
                  items = allClosedDates[index];
                  return Card(
                    color: secondaryColor,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Get.to(() => UpdateCloseAccount(
                              id: allClosedDates[index]['id'].toString(),
                              mtn_cash: allClosedDates[index]['mtn'],
                              express_cash: allClosedDates[index]['express'],
                              ecobank_cash: allClosedDates[index]['ecobank'],
                              gtbank_cash: allClosedDates[index]['gtbank'],
                              calbank_cash: allClosedDates[index]['calbank'],
                              fidelity_cash: allClosedDates[index]['fidelity'],
                              debit_cash: allClosedDates[index]['debit'],
                              over_cash: allClosedDates[index]['over'],
                              shortage_cash: allClosedDates[index]['shortage'],
                              cl1_cash: allClosedDates[index]['cash_left_at1'],
                              cl2_cash: allClosedDates[index]['cash_left_at2'],
                              cl3_cash: allClosedDates[index]['cash_left_at3'],
                              cl4_cash: allClosedDates[index]['cash_left_at4'],
                              cl5_cash: allClosedDates[index]['cash_left_at5'],
                              cl6_cash: allClosedDates[index]['cash_left_at6'],
                              cl7_cash: allClosedDates[index]['cash_left_at7'],
                              cl8_cash: allClosedDates[index]['cash_left_at8'],
                              cl9_cash: allClosedDates[index]['cash_left_at9'],
                              cl10_cash: allClosedDates[index]
                                  ['cash_left_at10'],
                              user1: allClosedDates[index]['user1'],
                              user2: allClosedDates[index]['user2'],
                              user3: allClosedDates[index]['user3'],
                              user4: allClosedDates[index]['user4'],
                              user5: allClosedDates[index]['user5'],
                              user6: allClosedDates[index]['user6'],
                              user7: allClosedDates[index]['user7'],
                              user8: allClosedDates[index]['user8'],
                              user9: allClosedDates[index]['user9'],
                              user10: allClosedDates[index]['user10'],
                              credit1: allClosedDates[index]['user_to_credit1'],
                              credit2: allClosedDates[index]['user_to_credit2'],
                              credit3: allClosedDates[index]['user_to_credit3'],
                              credit4: allClosedDates[index]['user_to_credit4'],
                              credit5: allClosedDates[index]['user_to_credit5'],
                              credit6: allClosedDates[index]['user_to_credit6'],
                              credit7: allClosedDates[index]['user_to_credit7'],
                              credit8: allClosedDates[index]['user_to_credit8'],
                              credit9: allClosedDates[index]['user_to_credit9'],
                              credit10: allClosedDates[index]
                                  ['user_to_credit10'],
                              acredit1: allClosedDates[index]
                                  ['amount_to_credit1'],
                              acredit2: allClosedDates[index]
                                  ['amount_to_credit2'],
                              acredit3: allClosedDates[index]
                                  ['amount_to_credit3'],
                              acredit4: allClosedDates[index]
                                  ['amount_to_credit4'],
                              acredit5: allClosedDates[index]
                                  ['amount_to_credit5'],
                              acredit6: allClosedDates[index]
                                  ['amount_to_credit6'],
                              acredit7: allClosedDates[index]
                                  ['amount_to_credit7'],
                              acredit8: allClosedDates[index]
                                  ['amount_to_credit8'],
                              acredit9: allClosedDates[index]
                                  ['amount_to_credit9'],
                              acredit10: allClosedDates[index]
                                  ['amount_to_credit10'],
                              total: allClosedDates[index]['total'],
                            ));
                      },
                      title: RowWidget(
                        items: items,
                        title: 'Total: ',
                        itemTitle: 'total'.toString(),
                      ),
                      subtitle: Column(
                        children: [
                          items['mtn'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'Mtn: ',
                                  itemTitle: 'mtn'.toString(),
                                )
                              : Container(),
                          items['express'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'Express: ',
                                  itemTitle: 'express'.toString(),
                                )
                              : Container(),
                          items['ecobank'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'EcoBank: ',
                                  itemTitle: 'ecobank'.toString(),
                                )
                              : Container(),
                          items['gtbank'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'GT Bank: ',
                                  itemTitle: 'gtbank'.toString(),
                                )
                              : Container(),
                          items['calbank'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cal Bank: ',
                                  itemTitle: 'calbank'.toString(),
                                )
                              : Container(),
                          items['fidelity'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'Fidelity: ',
                                  itemTitle: 'fidelity'.toString(),
                                )
                              : Container(),
                          items['debit'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'Debit: ',
                                  itemTitle: 'debit'.toString(),
                                )
                              : Container(),
                          items['over'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'Over: ',
                                  itemTitle: 'over'.toString(),
                                )
                              : Container(),
                          items['shortage'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'Shortage: ',
                                  itemTitle: 'shortage'.toString(),
                                )
                              : Container(),
                          items['cash_left_at1'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at1',
                                )
                              : Container(),
                          items['cash_left_at2'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at2',
                                )
                              : Container(),
                          items['cash_left_at3'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at3',
                                )
                              : Container(),
                          items['cash_left_at4'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at4',
                                )
                              : Container(),
                          items['cash_left_at5'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at5',
                                )
                              : Container(),
                          items['cash_left_at6'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at6',
                                )
                              : Container(),
                          items['cash_left_at7'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at7',
                                )
                              : Container(),
                          items['cash_left_at8'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at8',
                                )
                              : Container(),
                          items['cash_left_at9'] != "Select cash left @"
                              ? RowWidget(
                                  items: items,
                                  title: 'Cash Left @: ',
                                  itemTitle: 'cash_left_at9',
                                )
                              : Container(),
                          items['user1'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user1',
                                )
                              : Container(),
                          items['user2'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user2',
                                )
                              : Container(),
                          items['user3'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user3',
                                )
                              : Container(),
                          items['user4'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user4',
                                )
                              : Container(),
                          items['user5'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user5',
                                )
                              : Container(),
                          items['user6'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user6',
                                )
                              : Container(),
                          items['user7'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user7',
                                )
                              : Container(),
                          items['user8'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user8',
                                )
                              : Container(),
                          items['user9'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user9',
                                )
                              : Container(),
                          items['user10'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user10',
                                )
                              : Container(),

                          // for users and credits
                          items['user_to_credit1'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit1',
                                )
                              : Container(),
                          items['amount_to_credit1'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit1'.toString(),
                                )
                              : Container(),
                          items['user_to_credit2'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit2',
                                )
                              : Container(),
                          items['amount_to_credit2'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit2'.toString(),
                                )
                              : Container(),
                          items['user_to_credit3'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit3',
                                )
                              : Container(),
                          items['amount_to_credit3'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit3'.toString(),
                                )
                              : Container(),
                          items['user_to_credit4'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit4',
                                )
                              : Container(),
                          items['amount_to_credit4'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit4'.toString(),
                                )
                              : Container(),
                          items['user_to_credit5'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit5',
                                )
                              : Container(),
                          items['amount_to_credit5'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit5'.toString(),
                                )
                              : Container(),
                          items['user_to_credit6'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit6',
                                )
                              : Container(),
                          items['amount_to_credit6'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit6'.toString(),
                                )
                              : Container(),
                          items['user_to_credit7'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit7',
                                )
                              : Container(),
                          items['amount_to_credit7'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit7'.toString(),
                                )
                              : Container(),
                          items['user_to_credit8'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit8',
                                )
                              : Container(),
                          items['amount_to_credit8'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit8'.toString(),
                                )
                              : Container(),
                          items['user_to_credit9'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit9',
                                )
                              : Container(),
                          items['amount_to_credit9'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit9'.toString(),
                                )
                              : Container(),
                          items['user_to_credit10'] != ""
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'user_to_credit10',
                                )
                              : Container(),
                          items['amount_to_credit10'] != "0.00"
                              ? RowWidget(
                                  items: items,
                                  title: 'User: ',
                                  itemTitle: 'amount_to_credit10'.toString(),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Text("Date Created: ",
                                    style: TextStyle(
                                        color: defaultTextColor1,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    items['date_created']
                                        .toString()
                                        .split('T')
                                        .first,
                                    style: const TextStyle(
                                        color: defaultTextColor1,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            isPosting = true;
                            isLoading = true;
                          });
                          deleteAccount(allClosedDates[index]['id'].toString());
                        },
                        icon:
                            const Icon(Icons.delete_forever, color: Colors.red),
                      ),
                    ),
                  );
                }));
  }
}

class RowWidget extends StatelessWidget {
  String title;
  String itemTitle;
  RowWidget(
      {super.key,
      required this.items,
      required this.title,
      required this.itemTitle});

  final items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: defaultTextColor1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 8),
          child: Text(
            items[itemTitle].toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: defaultTextColor1),
          ),
        ),
      ],
    );
  }
}
