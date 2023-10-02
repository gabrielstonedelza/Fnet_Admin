import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/accountscontroller.dart';
import 'agentsdetail.dart';

class MyAgents extends StatefulWidget {
  MyAgents({super.key});

  @override
  State<MyAgents> createState() => _MyAgentsState();
}

class _MyAgentsState extends State<MyAgents> {
  var items;

  final AccountsController controller = Get.find();

  final storage = GetStorage();

  late String uToken = "";

  @override
  void initState() {
    // TODO: implement initState
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Agents"),
        // backgroundColor: secondaryColor,
        actions: [
          IconButton(
            onPressed: () {
              controller.getAllMyAgents(uToken);
            },
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
          )
        ],
      ),
      body: GetBuilder<AccountsController>(
        builder: (controller) {
          return ListView.builder(
              itemCount: controller.allMyAgents != null
                  ? controller.allMyAgents.length
                  : 0,
              itemBuilder: (context, i) {
                items = controller.allMyAgents[i];
                return Card(
                  color: secondaryColor,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => AgentDetails(
                          username: controller.allMyAgents[i]['username'],
                          phone: controller.allMyAgents[i]['phone']));
                    },
                    title: buildRow("Name: ", "full_name"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRow("Username : ", "username"),
                        buildRow("Phone : ", "phone"),
                        buildRow("Email : ", "email"),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 1.0, bottom: 8, top: 3),
                          child: Text(
                            "Tap for more",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: snackBackground),
                          ),
                        )
                      ],
                    ),
                    trailing: items['user_blocked']
                        ? IconButton(
                            onPressed: () async {
                              Get.snackbar("Please wait...", "unblocking agent",
                                  colorText: defaultTextColor1,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 5),
                                  backgroundColor: snackBackground);
                              controller.removeFromBlockedList(
                                  controller.allMyAgents[i]['id'].toString(),
                                  controller.allMyAgents[i]['email'],
                                  controller.allMyAgents[i]['username'],
                                  controller.allMyAgents[i]['phone'],
                                  controller.allMyAgents[i]['full_name'],
                                  uToken);
                              await Future.delayed(const Duration(seconds: 3));
                              controller.getAllMyAgents(uToken);
                            },
                            icon: Image.asset("assets/images/blocked.png",
                                width: 100, height: 100))
                        : IconButton(
                            onPressed: () async {
                              Get.snackbar("Please wait...", "blocking user",
                                  colorText: defaultTextColor1,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 5),
                                  backgroundColor: snackBackground);
                              controller.addToBlockedList(
                                  controller.allMyAgents[i]['id'].toString(),
                                  controller.allMyAgents[i]['email'],
                                  controller.allMyAgents[i]['username'],
                                  controller.allMyAgents[i]['phone'],
                                  controller.allMyAgents[i]['full_name'],
                                  uToken);
                              await Future.delayed(const Duration(seconds: 3));
                              controller.getAllMyAgents(uToken);
                            },
                            icon: Image.asset("assets/images/user-blocked.png",
                                width: 100, height: 100)),
                  ),
                );
              });
        },
      ),
    );
  }

  Padding buildRow(String mainTitle, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            items[subtitle],
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
