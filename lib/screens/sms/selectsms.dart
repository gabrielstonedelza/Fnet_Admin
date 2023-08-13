
import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/sms/sendagentsms.dart';
import 'package:fnet_admin/screens/sms/sendcustomersms.dart';
import 'package:get/get.dart';

import '../../static/app_colors.dart';


class SelectSms extends StatelessWidget {
  const SelectSms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Select to send sms"),
       ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [

              GestureDetector(
                onTap: () {
                  Get.to(() => const SendAgentsSms());
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/telephone-call.png",
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Users",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 100,),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SendCustomersSms());
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/telephone-call.png",
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Customers",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ])
          ],
        ));
  }
}
