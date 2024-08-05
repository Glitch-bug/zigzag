// ignore_for_file: avoid_print, depend_on_referenced_packages, camel_case_types, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API_MODEL/wallet_report_api_model.dart';
import '../Sub_Screen/top_up_screen.dart';
import '../config/config.dart';
import 'package:http/http.dart' as http;

import '../config/light_and_dark.dart';

class My_Wallet extends StatefulWidget {

  const My_Wallet({super.key});

  @override
  State<My_Wallet> createState() => _My_WalletState();
}

class _My_WalletState extends State<My_Wallet> {

  WalletReport? data;
  var daat;
  bool isloading = true;

  // Wallet_Report Api

  Future Walletreport(String uid) async {

    Map body = {
      'uid' : uid,
    };

    print("+++ $body");

    try{
      var response = await http.post(Uri.parse('${config().baseUrl}/api/wallet_report.php'), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
      });

      print(response.body);
      if(response.statusCode == 200){
        setState(() {
          data = walletReportFromJson(response.body);
          isloading = false;
          print('+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${data!.wallet}');
          // isloading = false;
        });
      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

  var userData;
  var searchbus;

  getlocledata() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      userData  = jsonDecode(_prefs.getString("loginData")!);
      searchbus = jsonDecode(_prefs.getString('currency')!);
      Walletreport(userData['id']);
      print('+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${userData["mobile"]}');
      print('+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+$searchbus');
    });
  }

  @override
  void initState() {
    getlocledata();
    super.initState();
  }

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.backgroundgray,
      appBar: AppBar(
        backgroundColor: const Color(0xff2C2C2C),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(child: Text('My Wallet'.tr,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
      ),
      body: isloading ? const Center(child: CircularProgressIndicator(color: Color(0xff7D2AFF)),) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Image(image: AssetImage('assets/Visa_card.png')),
              Padding(
                padding: const EdgeInsets.only(top: 40,left: 30,right: 30),
                // padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text(userData['name'],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                    const SizedBox(height: 30,),
                    Text('Your balance'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Text('$searchbus ${data!.wallet}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 0,right: 50),
                          child: InkWell(
                             onTap: () {
                             // Navigator.push(context, MaterialPageRoute(builder: (context) => Top_up(wallet: data!.wallet,searchbus: searchbus),));
                             Get.to(Top_up(wallet: data!.wallet,searchbus: searchbus))!.then((value) {
                               print("+1222222222222211111111111122224185410241514$value");
                               Walletreport(userData['id']);
                             });
                             },
                            child: Container(
                              height: 35,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                              ),
                              child:  Row(
                                children: [
                                  const Spacer(),
                                  const Image(image: AssetImage('assets/Top_up.png'),height: 15,width: 15,),
                                  const SizedBox(width: 5,),
                                  Text('Top up'.tr,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
           Padding(
            padding: const EdgeInsets.only(left: 13,right: 13),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Transaction History'.tr,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: notifier.textColor),),
                    const Spacer(),
                    // Text('View All',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xff7D2AFF)),),
                    const Icon(Icons.keyboard_arrow_right,color: Color(0xff7D2AFF),),
                  ],
                ),
              ],
            ),
          ),

          // const ExpansionTile(
          //   title: Text('Transaction History',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          //   children: <Widget>[
          //     ListTile(title: Text('This is tile number 1')),
          //   ],
          // ),

          const SizedBox(height: 20,),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(width : 0,);
                },
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data!.walletitem.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(data!.walletitem[index].message,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: notifier.textColor)),
                    subtitle: Transform.translate(offset: const Offset(0, 5),child: Text(data!.walletitem[index].status,style: const TextStyle(fontSize: 14,color: Colors.grey))),
                    trailing: Text('${data!.walletitem[index].status == 'Debit' ? '-' : "+"} $searchbus${data!.walletitem[index].amt}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:  data!.walletitem[index].status == "Debit"  ? Colors.red : Colors.green)),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
