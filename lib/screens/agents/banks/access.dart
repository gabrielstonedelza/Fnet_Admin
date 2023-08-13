import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../static/app_colors.dart';
import '../../../widgets/loadingui.dart';
import 'accesssummarydetail.dart';

class AccessBankDepositRequests extends StatefulWidget {
  final username;
  const AccessBankDepositRequests({super.key,required this.username});

  @override
  State<AccessBankDepositRequests> createState() => _AccessBankDepositRequestsState(username:this.username);
}

class _AccessBankDepositRequestsState extends State<AccessBankDepositRequests> {
  final username;
  _AccessBankDepositRequestsState({required this.username});

  late List allAccessRequests = [];
  var items;
  bool isLoading = true;

  late List requestsDates = [];

  Future<void>fetchAllAccessBankRequests()async{
    final url = "https://fnetghana.xyz/get_agents_access_bank/$username/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink, headers: {
      // "Authorization": "Token $uToken"
    });

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allAccessRequests = json.decode(jsonData);

      for(var i in allAccessRequests){
        if(!requestsDates.contains(i['date_requested'].toString().split("T").first)){
          requestsDates.add(i['date_requested'].toString().split("T").first);
        }
      }
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
    fetchAllAccessBankRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$username's Access Bank"),
      ),
      body: isLoading ? const LoadingUi() :
      ListView.builder(
          itemCount: requestsDates != null ? requestsDates.length : 0,
          itemBuilder: (context,i){
            items = requestsDates[i];
            return Column(
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AccessBankSummaryDetail(date_requested:requestsDates[i],username:username);
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Card(
                      color: secondaryColor,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      // shadowColor: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                const Text("Date: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                Text(items,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}
