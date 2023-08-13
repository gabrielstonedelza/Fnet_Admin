import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/static/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../controllers/accountscontroller.dart';
import 'agentsdetail.dart';



class MyAgents extends StatefulWidget {
  const MyAgents({Key? key}) : super(key: key);

  @override
  State<MyAgents> createState() => _MyAgentsState();
}

class _MyAgentsState extends State<MyAgents> {
  late String uToken = "";
  late String agentCode = "";
  final storage = GetStorage();
  var items;
  bool isLoading = true;
  late List allMyAgents = [];
  late List allBlockedUsers = [];
  bool isPosting = false;
  final AccountsController controller = Get.find();
  //
  // Future<void> getAllMyAgents() async {
  //   try {
  //     isLoading = true;
  //     const  allUsers = "https://fnetghana.xyz/all_agents/";
  //     var link = Uri.parse(allUsers);
  //     http.Response response = await http.get(link, headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       "Authorization": "Token $uToken"
  //     });
  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);
  //       allMyAgents.assignAll(jsonData);
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     Get.snackbar("Sorry","something happened or please check your internet connection");
  //   }
  // }
  //
  // Future<void>fetchBlockedAgents()async{
  //   const url = "https://fnetghana.xyz/get_all_blocked_users/";
  //   var myLink = Uri.parse(url);
  //   final response = await http.get(myLink, headers: {
  //     "Content-Type": "application/x-www-form-urlencoded",
  //     // "Authorization": "Token $uToken"
  //   });
  //
  //   if(response.statusCode ==200){
  //     final codeUnits = response.body.codeUnits;
  //     var jsonData = const Utf8Decoder().convert(codeUnits);
  //     allBlockedUsers = json.decode(jsonData);
  //     if (kDebugMode) {
  //       print(allBlockedUsers);
  //     }
  //     setState(() {
  //       isLoading = false;
  //       allBlockedUsers = allBlockedUsers;
  //     });
  //   }
  //
  // }
  addToBlockedList(String userId,String email,String username,String phone,String fullName) async {
    final depositUrl = "https://fnetghana.xyz/update_blocked/$userId/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    }, body: {
      "user_blocked": "True",
      "email": email,
      "username": username,
      "phone": phone,
      "full_name": fullName,
    });
    if (res.statusCode == 201) {
      setState(() {
        isLoading = false;
      });
      controller.getAllMyAgents();
      Get.snackbar("Success", "blocking agent",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: snackBackground);
    }
    else{
      if (kDebugMode) {
        print(res.body);
      }
    }
  }

  removeFromBlockedList(String userId,String email,String username,String phone,String fullName) async {
    final depositUrl = "https://fnetghana.xyz/update_blocked/$userId/";
    final myLink = Uri.parse(depositUrl);
    final res = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Token $uToken"
    }, body: {
      "user_blocked": "False",
      "email": email,
      "username": username,
      "phone": phone,
      "full_name": fullName,
    });
    if (res.statusCode == 201) {
      setState(() {
        isLoading = false;
      });
      controller.getAllMyAgents();
      Get.snackbar("Success", "agent is removed from block lists",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: snackBackground);
    }
    else{
      if (kDebugMode) {
        // print(res.body);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (storage.read("token") != null) {
      setState(() {
        uToken = storage.read("token");
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Agents"),
        // backgroundColor: secondaryColor,
        actions: [
          IconButton(
            onPressed: (){
              controller.getAllMyAgents();
            },
            icon: const Icon(Icons.refresh,size: 30,),
          )
        ],
      ),
      body: GetBuilder<AccountsController>(builder: (controller){
        return ListView.builder(
            itemCount: controller.allMyAgents != null ? controller.allMyAgents.length : 0,
            itemBuilder: (context, i) {
              items = controller.allMyAgents[i];
              return Card(
                color: secondaryColor,
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  onTap: (){
                    Get.to(()=>AgentDetails(username:controller.allMyAgents[i]['username']));
                  },
                  title: buildRow("Name: ", "full_name"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRow("Username : ", "username"),
                      buildRow("Phone : ", "phone"),
                      buildRow("Email : ", "email"),
                      const Padding(
                        padding: EdgeInsets.only(left: 1.0,bottom: 8,top: 3),
                        child: Text("Tap for more",style: TextStyle(fontWeight: FontWeight.bold,color: snackBackground),),
                      )
                    ],
                  ),
                  trailing: items['user_blocked'] ? IconButton(
                      onPressed: () async{
                        Get.snackbar("Please wait...", "unblocking agent",
                            colorText: defaultTextColor1,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 5),
                            backgroundColor: snackBackground);
                        removeFromBlockedList(controller.allMyAgents[i]['id'].toString(),controller.allMyAgents[i]['email'],controller.allMyAgents[i]['username'],controller.allMyAgents[i]['phone'],controller.allMyAgents[i]['full_name']);
                        await Future.delayed(const Duration(seconds: 3));
                        controller.getAllMyAgents();
                      },
                      icon:Image.asset("assets/images/blocked.png",width:100,height:100)
                  ) : IconButton(
                      onPressed: () async{
                        Get.snackbar("Please wait...", "blocking user",
                            colorText: defaultTextColor1,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 5),
                            backgroundColor: snackBackground);
                        addToBlockedList(controller.allMyAgents[i]['id'].toString(),controller.allMyAgents[i]['email'],controller.allMyAgents[i]['username'],controller.allMyAgents[i]['phone'],controller.allMyAgents[i]['full_name']);
                        await Future.delayed(const Duration(seconds: 3));
                        controller.getAllMyAgents();
                      },
                      icon:Image.asset("assets/images/user-blocked.png",width:100,height:100)
                  ),
                ),
              );
            });
      },),

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
