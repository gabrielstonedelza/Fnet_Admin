import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fnet_admin/screens/payments/paymentdetail.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../static/app_colors.dart';

class AllPayments extends StatefulWidget {
  const AllPayments({super.key});

  @override
  State<AllPayments> createState() => _AllPaymentsState();
}

class _AllPaymentsState extends State<AllPayments> {
  // final RequestController requestController = Get.find();
  var items;
  late List allPayments = [];
  late List allPaymentDates = [];
  bool isLoading = true;

  Future<void> getAllPayments() async {
    const profileLink = "https://fnetghana.xyz/admin_get_all_bank_payments/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      allPayments.assignAll(jsonData);
      for (var i in allPayments) {
        if (!allPaymentDates.contains(i['date_created'])) {
          allPaymentDates.add(i['date_created']);
        }
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
  // late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Payments"),
        ),
        body: isLoading
            ? const LoadingUi()
            : ListView.builder(
                itemCount: allPaymentDates != null ? allPaymentDates.length : 0,
                itemBuilder: (context, index) {
                  items = allPaymentDates[index];
                  return Card(
                    color: secondaryColor,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Get.to(() => PaymentDetail(
                            date_created: allPaymentDates[index]));
                      },
                      title: Text(
                        items,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: defaultTextColor1),
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
            items[itemTitle],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: defaultTextColor1),
          ),
        ),
      ],
    );
  }
}
