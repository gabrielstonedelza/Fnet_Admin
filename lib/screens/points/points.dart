import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/points/pointsformonth.dart';
import 'package:fnet_admin/screens/points/pointsfortoday.dart';
import 'package:fnet_admin/screens/points/pointsforweek.dart';
import 'package:fnet_admin/screens/points/searchmonth.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:get/get.dart';

import '../homepage.dart';
import 'allpoints.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Points"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Get.to(() => const PointsForToday());
                },
                child: menuWidget(
                  title: 'Today',
                  imagePath: 'assets/images/customer-loyalty.png',
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Get.to(() => const PointsForWeek());
                },
                child: menuWidget(
                  title: 'Weekly',
                  imagePath: 'assets/images/customer-loyalty.png',
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Get.to(() => const PointsForMonth());
                },
                child: menuWidget(
                  title: 'Monthly',
                  imagePath: 'assets/images/customer-loyalty.png',
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Get.to(() => const AllPoints());
                },
                child: menuWidget(
                  title: 'All',
                  imagePath: 'assets/images/customer-loyalty.png',
                ),
              )),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Get.to(() => const FetchPointsMonthly());
        },
        child: Image.asset(
          "assets/images/recruitment.png",
          width: 30,
          height: 30,
          color: defaultTextColor1,
        ),
      ),
    );
  }
}
