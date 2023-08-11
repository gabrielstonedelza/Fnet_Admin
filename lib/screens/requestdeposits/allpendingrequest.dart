import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/requestcontroller.dart';
import '../../static/app_colors.dart';
import 'ApproveDepositRequestDetail.dart';

class AllPendingDepositRequests extends StatefulWidget {
  const AllPendingDepositRequests({super.key});

  @override
  State<AllPendingDepositRequests> createState() => _AllPendingDepositRequestsState();
}

class _AllPendingDepositRequestsState extends State<AllPendingDepositRequests> {
  final RequestController requestController = Get.find();
  var items;
  // late Timer _timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: GetBuilder<RequestController>(builder:(controller){
        return ListView.builder(
          itemCount: controller.allRequests != null ? controller.allRequests.length : 0,
            itemBuilder: (context,index){
            items = controller.allRequests[index];
            return Card(
              color: secondaryColor,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                onTap: (){
                  Get.to(() => ApproveDepositRequestDetail(agent: controller.allRequests[index]['agent'].toString(), id: controller.allRequests[index]['id'].toString()),);
                },
                title: Text(items['agent_username']),
              ),
            );
        });
      }),
    );
  }
}
