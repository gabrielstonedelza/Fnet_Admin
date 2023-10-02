import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../../controllers/pointscontroller.dart';
import '../../static/app_colors.dart';

class PointsForToday extends StatefulWidget {
  const PointsForToday({super.key});

  @override
  State<PointsForToday> createState() => _PointsForTodayState();
}

class _PointsForTodayState extends State<PointsForToday> {
  final PointsController controller = Get.find();
  final storage = GetStorage();
  late String uToken = "";
  var items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    controller.getAllAccountsWithPointsForToday(uToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Points for Today"),
      ),
      body: GetBuilder<PointsController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.pointsForToday != null
                ? controller.pointsForToday.length
                : 0,
            itemBuilder: (context, index) {
              items = controller.pointsForToday[index];
              return Card(
                color: secondaryColor,
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: RowWidget(
                    items: items,
                    title: 'Agent: ',
                    itemTitle: 'get_agent_username',
                  ),
                  subtitle: Column(
                    children: [
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
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Points: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: defaultTextColor1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              items['points'].toString(),
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
                              "Date: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: defaultTextColor1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              items['date_deposited'],
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
                              items['time_deposited']
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
                    ],
                  ),
                ),
              );
            });
      }),
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
