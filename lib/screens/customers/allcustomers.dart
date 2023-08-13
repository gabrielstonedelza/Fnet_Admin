import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fnet_admin/screens/customers/searchcustomers.dart';
import 'package:fnet_admin/widgets/loadingui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controllers/customerscontroller.dart';
import '../../static/app_colors.dart';

class AllCustomers extends StatefulWidget {
  const AllCustomers({super.key});

  @override
  State<AllCustomers> createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  // final CustomersController controller = Get.find();
  var items;
  late List allCustomers = [];
  bool isLoading = true;
  Future<void> getAllCustomers() async {
    const profileLink = "https://www.fnetghana.xyz/all_customers/";
    var link = Uri.parse(profileLink);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      // "Authorization": "Token $uToken"
    });

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      allCustomers.assignAll(jsonData);
      setState(() {
        isLoading = false;
      });
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),
      body: isLoading ? const LoadingUi() : ListView.builder(
          itemCount: allCustomers != null
              ? allCustomers.length
              : 0,
          itemBuilder: (context, index) {
            items = allCustomers[index];
            return Card(
              color: secondaryColor,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                // leading: const Icon(Icons.person),
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8),
                  child: Row(
                    children: [
                      const Text("Name: ",style: TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                      Text(items['name'],style: const TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Phone: ",style: TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                        Text(items['phone'],style: const TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Location: ",style: TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                        Text(items['location'],style: const TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Dig Add: ",style: TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                        Text(items['digital_address'],style: const TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Dob: ",style: TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                        Text(items['date_of_birth'],style: const TextStyle(color: defaultTextColor1,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: (){
          Get.to(() => const SearchCustomers());
        },
        child: Image.asset("assets/images/recruitment.png",width: 30,height: 30,color: defaultTextColor1,),
      ),
    );
  }
}
