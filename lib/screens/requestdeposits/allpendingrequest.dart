import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/requestcontroller.dart';
import '../../static/app_colors.dart';
import 'ApproveDepositRequestDetail.dart';
import 'allrequests.dart';

class AllPendingDepositRequests extends StatefulWidget {
  const AllPendingDepositRequests({super.key});

  @override
  State<AllPendingDepositRequests> createState() =>
      _AllPendingDepositRequestsState();
}

class _AllPendingDepositRequestsState extends State<AllPendingDepositRequests> {
  // final RequestController requestController = Get.find();
  var items;
  late List allPendingRequests = [];
  bool isLoading = true;

  Future<void> getAllPendingRequestDeposits() async {
    const profileLink =
        "https://fnetghana.xyz/admin_get_all_pending_bank_deposits/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      allPendingRequests.assignAll(jsonData);
      setState(() {
        isLoading = false;
      });
    } else {
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  // late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPendingRequestDeposits();
    // requestController.getAllPendingRequestDeposits();
    // _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //   requestController.getAllPendingRequestDeposits;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Requests"),
      ),
      body: isLoading
          ? const LoadingUi()
          : ListView.builder(
              itemCount:
                  allPendingRequests != null ? allPendingRequests.length : 0,
              itemBuilder: (context, index) {
                items = allPendingRequests[index];
                return Card(
                  color: secondaryColor,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      Get.to(
                        () => ApproveDepositRequestDetail(
                            agent:
                                allPendingRequests[index]['agent'].toString(),
                            id: allPendingRequests[index]['id'].toString(),
                            bank: allPendingRequests[index]['bank'],
                            amount: allPendingRequests[index]['amount'],
                            accnum: allPendingRequests[index]['account_number'],
                            userLoc: allPendingRequests[index]
                                ['user_location']),
                      );
                    },
                    title: RowWidget(
                      items: items,
                      title: 'Agent: ',
                      itemTitle: 'agent_username',
                    ),
                    subtitle: Column(
                      children: [
                        RowWidget(
                          items: items,
                          title: 'Location: ',
                          itemTitle: 'user_location',
                        ),
                        RowWidget(
                          items: items,
                          title: 'Customer: ',
                          itemTitle: 'customer',
                        ),
                        RowWidget(
                          items: items,
                          title: 'Bank: ',
                          itemTitle: 'bank',
                        ),
                        RowWidget(
                          items: items,
                          title: 'Acc No: ',
                          itemTitle: 'account_number',
                        ),
                        RowWidget(
                          items: items,
                          title: 'Acc Name: ',
                          itemTitle: 'account_name',
                        ),
                        RowWidget(
                          items: items,
                          title: 'Amount: ',
                          itemTitle: 'amount',
                        ),
                        RowWidget(
                          items: items,
                          title: 'Req Status: ',
                          itemTitle: 'request_status',
                        ),
                        RowWidget(
                          items: items,
                          title: 'Req Paid: ',
                          itemTitle: 'deposit_paid',
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Date: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: defaultTextColor1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                items['date_requested'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: defaultTextColor1),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Time: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: defaultTextColor1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                items['time_requested']
                                    .toString()
                                    .split(".")
                                    .first,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: defaultTextColor1),
                              ),
                            ),
                          ],
                        ),
                        const Text("Tap to approve",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))
                      ],
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Get.to(() => const AllDepositRequests());
        },
        child: const Text("All"),
      ),
    );
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
            items[itemTitle],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: defaultTextColor1),
          ),
        ),
      ],
    );
  }
}
