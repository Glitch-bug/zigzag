// ignore_for_file: unused_field, unused_element, depend_on_referenced_packages, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, avoid_init_to_null, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zigzag/config/demo2.dart';

import '../API_MODEL/new_request_api_model.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;

import '../API_MODEL/post_revie_api_model.dart';
import '../Common_Code/common_button.dart';
import '../config/config.dart';
import '../config/light_and_dark.dart';
import 'search_bus_screen.dart';

class Booking_Details extends StatefulWidget {
  final String ticket_id;
  final bool isDownload;
  const Booking_Details(
      {super.key, required this.ticket_id, required this.isDownload});

  @override
  State<Booking_Details> createState() => _Booking_DetailsState();
}

class _Booking_DetailsState extends State<Booking_Details> {
  @override
  void initState() {
    getlocledata();

    setState(() {
      // subtotal = data1!.tickethistory[0].subtotal;
      // tax = data1!.tickethistory[0].taxAmt;

      // totalPayment = int.parse(subtotal) + int.parse(subtotal) * int.parse(tax) / 100;

      // totalPayment = int.parse(data1!.tickethistory[0].subtotal) + int.parse(data1!.tickethistory[0].subtotal) * int.parse(data1!.tickethistory[0].taxAmt) / 100;
    });

    super.initState();
  }

  var userData;
  var searchbus;

  getlocledata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = jsonDecode(prefs.getString("loginData")!);
      searchbus = jsonDecode(prefs.getString('currency')!);

      New_Requist(userData["id"], widget.ticket_id).then((value) {
        setState(() {
          subtotal = data1!.tickethistory[0].subtotal;
          tax = data1!.tickethistory[0].taxAmt;
          numbers = data1!.tickethistory[0].subPickMobile.toString().split(",");
          print(numbers);
          totalPayment = int.parse(subtotal) * int.parse(tax) / 100;
        });
      });

      // New_Requist(userData["id"]);

      print(
          '+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${userData["mobile"]}');
    });
  }

  bool isloading = true;
  Newrequist? data1;

  double? totalPayment;

  String subtotal = "";
  String tax = "";

  var capturedFile;
  var imagePath;

  Future New_Requist(String uid, String ticket_id) async {
    Map body = {
      'uid': uid,
      'ticket_id': widget.ticket_id,
    };

    print("+++--++ $body");

    try {
      var response = await http.post(
          Uri.parse('${config().baseUrl}/api/booking_details.php'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
          });

      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          data1 = newrequistFromJson(response.body);
        });
        setState(() {
          isloading = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            "tickethistory", jsonEncode(data1?.tickethistory[0].ticketId));
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Postreview? data;
  TextEditingController reviwcontroller = TextEditingController();
  List numbers = [];
  Future Post_Revie_Api(String uid, String ticket_id) async {
    Map body = {
      'uid': uid,
      'ticket_id': widget.ticket_id,
      "total_rate": raing,
      "rate_text": reviwcontroller.text
    };

    print("+++--++ $body");

    try {
      var response = await http.post(
          Uri.parse('${config().baseUrl}/api/u_rate_update.php'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
          });

      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          data = postreviewFromJson(response.body);
        });
        setState(() {
          isloading = false;
        });
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final GlobalKey _globalKey = GlobalKey();

  final double _userRating = 3.0;

  IconData? _selectedIcon;
  final bool _isVertical = false;
  double raing = 0;

  final pdf = pw.Document();
  late File? file = null;
  final netImage = networkImage('https://www.nfet.net/nfet.jpg');

  //-------------------------------

  writeOnPDF() async {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.SizedBox(
              height: 10,
            ),
            pw.ListView.builder(
                // separatorBuilder: (context, index) {
                //   return  pw.SizedBox(height: 0);
                // },
                // shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                itemCount: data1!.tickethistory.length,
                itemBuilder: (context, int index) {
                  // var date1 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busPicktime));
                  // var date2 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busDroptime));

                  return pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 0),
                    child: pw.Container(
                      // height: 200,
                      // width: MediaQuery.of(context).size.width*0.8,
                      margin: const pw.EdgeInsets.only(bottom: 0),
                      decoration: pw.BoxDecoration(
                        // color: Colors.white,
                        borderRadius: pw.BorderRadius.circular(0),
                      ),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 15, bottom: 15),
                        child: pw.Column(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(right: 15),
                              child: pw.Row(
                                children: [
                                  // pw.Container(
                                  //     height: 35,
                                  //     width: 35,
                                  //     decoration: pw.BoxDecoration(
                                  //         // color: Colors.red,
                                  //         borderRadius: pw.BorderRadius.circular(65),
                                  //         // image: pw.DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.tickethistory[index].busImg}'),fit: pw.BoxFit.fill))
                                  //         image: pw.DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.tickethistory[index].busImg}'),fit: pw.BoxFit.fill))
                                  // ),
                                  pw.SizedBox(
                                    width: 15,
                                  ),
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                          '${data1?.tickethistory[index].busName}',
                                          style: pw.TextStyle(
                                            fontSize: 17,
                                            fontWeight: pw.FontWeight.bold,
                                          )),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Row(
                                        children: [
                                          if (data1
                                                  ?.tickethistory[index].isAc ==
                                              '1')
                                            pw.Text('AC Seater '.tr),
                                          // if(data.busData[index].isSleeper == '1') const Text('/ Sleeper  '),
                                          // Text('${data.busData[index].totlSeat} Seat',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                        ],
                                      )
                                      // const Text('Economy'),
                                    ],
                                  ),
                                  pw.Spacer(),
                                  // const Text('Available',style: TextStyle(color: Colors.green,fontSize: 13),),
                                  pw.SizedBox(
                                    width: 4,
                                  ),
                                  pw.Text(
                                    '$searchbus${data1?.tickethistory[0].total}',
                                    style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            pw.SizedBox(
                              height: 15,
                            ),
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.only(left: 15, right: 15),
                              child: pw.Row(
                                children: [
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        data1!
                                            .tickethistory[index].boardingCity,
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      pw.SizedBox(
                                        height: 8,
                                      ),
                                      pw.Text(
                                        convertTimeTo12HourFormat(data1!
                                            .tickethistory[index].busPicktime),
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 8,
                                      ),
                                      // Text(_selectedDate.toString().split(" ").first,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                      // const SizedBox(height: 8,),
                                      // Text('Seat : ${data.busData[index].totlSeat}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  pw.Spacer(),
                                  pw.Column(
                                    children: [
                                      // pw.Image(image: AssetImage('${image1}'),height: 50,width: 140),

                                      pw.Text(
                                          '${data1?.tickethistory[index].differencePickDrop}'),
                                    ],
                                  ),
                                  pw.Spacer(),
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        '${data1?.tickethistory[index].dropCity}',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      pw.SizedBox(
                                        height: 8,
                                      ),
                                      pw.Text(
                                        convertTimeTo12HourFormat(data1!
                                            .tickethistory[index].busDroptime),
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                      pw.SizedBox(
                                        height: 8,
                                      ),
                                      // Text('${_selectedDate.toString().split(" ").first}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                      // const SizedBox(height: 8,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            pw.SizedBox(
              height: 10,
            ),
            pw.Container(
              // height: 120,
              // width: MediaQuery.of(context).size.width,
              // color: Colors.white,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 15, right: 15),
                    child: pw.Row(
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(data1!.tickethistory[0].subPickPlace,
                                style: const pw.TextStyle(fontSize: 16)),
                            pw.Text(data1!.tickethistory[0].boardingCity,
                                style: const pw.TextStyle(fontSize: 16)),
                            pw.SizedBox(
                              height: 13,
                            ),
                            pw.Text(
                                convertTimeTo12HourFormat(
                                    data1!.tickethistory[0].busPicktime),
                                style: const pw.TextStyle(fontSize: 12)),
                          ],
                        ),
                        pw.Spacer(),
                        // pw. Column(
                        //   children: [
                        //     Image(image: AssetImage('assets/Group 3.png'),width: 20,height: 80,),
                        //   ],
                        // ),
                        pw.Spacer(),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(data1!.tickethistory[0].subDropPlace,
                                style: const pw.TextStyle(fontSize: 16)),
                            pw.Text(data1!.tickethistory[0].dropCity,
                                style: const pw.TextStyle(fontSize: 16)),
                            pw.SizedBox(
                              height: 13,
                            ),
                            pw.Text(
                                convertTimeTo12HourFormat(
                                    data1!.tickethistory[0].subDropTime),
                                style: const pw.TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Container(
              // height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: const pw.BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(20),
                  ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
                        pw.SizedBox(
                          width: 15,
                        ),
                        pw.Text(
                          'Bus Details'.tr,
                          style: const pw.TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 15, right: 15),
                      child: pw.Column(
                        children: [
                          pw.Row(
                            children: [
                              pw.Text('Bokking Date'.tr),
                              pw.Spacer(),
                              pw.Text(
                                  '${data1?.tickethistory[0].bookDate.toString().split(' ').first}'),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Payment Methode'.tr),
                              pw.Spacer(),
                              pw.Text('${data1?.tickethistory[0].pMethodName}'),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Transaction Id'.tr),
                              pw.Spacer(),
                              pw.Text(
                                  '${data1?.tickethistory[0].transactionId}'),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Ticket Id'.tr),
                              pw.Spacer(),
                              pw.Text('${data1?.tickethistory[0].ticketId}'),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Bus Number'.tr),
                              pw.Spacer(),
                              pw.Text('${data1?.tickethistory[0].busNo}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Container(
              // height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: const pw.BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(20),
                  ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
                        pw.SizedBox(
                          width: 15,
                        ),
                        pw.Text(
                          'Passenger(S)'.tr,
                          style: const pw.TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 15, right: 15),
                      child: pw.Column(
                        children: [
                          pw.Table(
                            // border: pw.TableBorder.all(),
                            columnWidths: <int, pw.TableColumnWidth>{
                              0: const pw.FixedColumnWidth(250),
                              1: const pw.FixedColumnWidth(40),
                              2: const pw.FixedColumnWidth(40),
                              3: const pw.FixedColumnWidth(40),
                            },
                            children: <pw.TableRow>[
                              pw.TableRow(
                                children: <pw.Widget>[
                                  pw.Text(
                                    'Name'.tr,
                                  ),
                                  pw.Center(child: pw.Text('Age'.tr)),
                                  pw.Center(child: pw.Text('Seat'.tr)),
                                  // Text('',style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              for (int a = 0;
                                  a <
                                      data1!.tickethistory[0].orderProductData
                                          .length;
                                  a++)
                                pw.TableRow(
                                  children: <pw.Widget>[
                                    pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 15),
                                      child: pw.Text(
                                          '${data1?.tickethistory[0].orderProductData[a].name} (${data1?.tickethistory[0].orderProductData[a].gender})'),
                                    ),

                                    pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 15),
                                      child: pw.Center(
                                          child: pw.Text(
                                        '${data1?.tickethistory[0].orderProductData[a].age}',
                                      )),
                                    ),
                                    // Text(widget.DataStore[index]["Age"],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                    pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 15),
                                      child: pw.Center(
                                          child: pw.Text(
                                              '${data1?.tickethistory[0].orderProductData[a].seatNo}')),
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 15),
                                    //   child: InkWell(
                                    //       onTap: () {
                                    //         Navigator.pop(context);
                                    //       },
                                    //       child: const Image(image: AssetImage('assets/editIcon.png'),height: 25,width: 25)),
                                    // ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Container(
              // height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: const pw.BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(20),
                  ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
                        pw.SizedBox(
                          width: 15,
                        ),
                        pw.Text('Contact Details'.tr),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 15, right: 15),
                      child: pw.Column(
                        children: [
                          pw.Row(
                            children: [
                              pw.Text('Full Name'.tr),
                              pw.Spacer(),
                              pw.Text(
                                '${data1?.tickethistory[0].contactName}',
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Email'.tr),
                              pw.Spacer(),
                              pw.Text(
                                '${data1?.tickethistory[0].contactEmail}',
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Phone Number'.tr),
                              pw.Spacer(),
                              pw.Text(
                                  '${data1?.tickethistory[0].contactMobile}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Container(
              // height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: const pw.BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(20),
                  ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
                        pw.SizedBox(
                          width: 15,
                        ),
                        pw.Text(
                          'Driver Details'.tr,
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 15, right: 15),
                      child: pw.Column(
                        children: [
                          pw.Row(
                            children: [
                              pw.Text('Driver Name'.tr),
                              pw.Spacer(),
                              pw.Text(
                                '${data1?.tickethistory[0].driverName}',
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Driver Number'.tr),
                              pw.Spacer(),
                              pw.Text(
                                '${data1?.tickethistory[0].driverMobile}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Container(
              // height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: const pw.BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(20),
                  ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
                        pw.SizedBox(
                          width: 15,
                        ),
                        pw.Text('Price Details'.tr,
                            style: const pw.TextStyle(fontSize: 17)),
                      ],
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 15, right: 15),
                      child: pw.Column(
                        children: [
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Price'.tr),
                              pw.Spacer(),
                              pw.Text(
                                '$searchbus ${data1?.tickethistory[0].subtotal}',
                                style: const pw.TextStyle(),
                              ),
                            ],
                          ),
                          // light ? const SizedBox(height: 15,) : const SizedBox(height: 0,),
                          // light ? switchcommoncode(): const SizedBox(),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                  'Tax(${data1?.tickethistory[0].taxAmt}%)'),
                              pw.Spacer(),
                              pw.Text(
                                '$searchbus $totalPayment',
                                style: const pw.TextStyle(),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Discount'.tr),
                              pw.Spacer(),
                              // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                              pw.Text(
                                '$searchbus ${data1?.tickethistory[0].couAmt}',
                                style: const pw.TextStyle(),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Wallet'.tr),
                              pw.Spacer(),
                              // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                              pw.Text(
                                '$searchbus ${data1?.tickethistory[0].wallAmt}',
                                style: const pw.TextStyle(),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Divider(),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Row(
                            children: [
                              pw.Text('Total Price'.tr),
                              pw.Spacer(),
                              // Text('${widget.currency} ${(totalAmount - coupon ) - walet} ',style: const TextStyle(fontWeight: FontWeight.bold),),
                              pw.Text(
                                '$searchbus ${data1?.tickethistory[0].total} ',
                                style: const pw.TextStyle(),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(
              height: 20,
            ),
          ];
        }));
  }

  Future savePDF() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String assets = documentDirectory.path;

    File file = File("$assets/label.pdf");
    print("$assets/label.pdf");
    file.writeAsBytes(await pdf.save());
    Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
    );
    Printing.sharePdf(bytes: await pdf.save(), filename: 'zigzag.pdf');

    setState(() {
      file = file;
    });
  }

  _makingPhoneCall(String number) async {
    var url = Uri.parse("tel:$number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // _makingPhoneCall() async {
  //   var url = Uri.parse("tel:9776765434");
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            color: notifier.containercoloreproper,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: widget.isDownload
                        ? InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PdfPreviewPage(
                                    data1: data1,
                                    searchbus: searchbus,
                                    totalPayment: totalPayment,
                                  );
                                },
                              ));

                              // writeOnPDF();
                              // savePDF();
                            },
                            child: CommonButton(
                                containcolore: const Color(0xff7D2AFF),
                                txt1: 'Download Ticket'.tr,
                                context: context))
                        : data1?.tickethistory[0].isRate == "0"
                            ? InkWell(
                                onTap: () {
                                  Get.bottomSheet(isScrollControlled: true,
                                      StatefulBuilder(
                                          builder: (context, setState) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 100),
                                      child: Container(
                                        // height: 200,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffEEEEEE),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/Group.png'))),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text('${userData['name']}',
                                                    style: const TextStyle(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                    '${data1?.tickethistory[0].busNo}',
                                                    style: const TextStyle(
                                                        fontSize: 15)),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                RatingBar.builder(
                                                    initialRating: 0,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    unratedColor:
                                                        const Color(0xffEEEEEE),
                                                    itemPadding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(Icons.star,
                                                            color: Color(
                                                                0xff7D2AFF),
                                                            size: 10),
                                                    onRatingUpdate: (rating) {
                                                      raing = rating;
                                                      print(rating);
                                                    }),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            reviwcontroller,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: 5,
                                                        // obscureText: obscureText ?? false,
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: '',
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          border:
                                                              const OutlineInputBorder(),
                                                          hintText:
                                                              'Enter your Feedback'
                                                                  .tr,
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.99),
                                                              fontFamily:
                                                                  'GilroyMedium'),
                                                          focusedBorder: const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xff5e59ff)),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          enabledBorder: const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xffd3d6da)),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Post_Revie_Api(
                                                          userData["id"],
                                                          widget.ticket_id);
                                                    },
                                                    child: CommonButton(
                                                        containcolore:
                                                            const Color(
                                                                0xff7D2AFF),
                                                        txt1: 'Rating'.tr,
                                                        context: context)),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                                },
                                child: CommonButton(
                                    containcolore: const Color(0xff7D2AFF),
                                    txt1: 'Completed'.tr,
                                    context: context))
                            : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
          // Text("$bottom",style: TextStyle(color: Colors.red)),
        ],
      ),
      // backgroundColor: const Color(0xffF5F5F5),
      backgroundColor: notifier.backgroundgray,
      appBar: AppBar(
        backgroundColor: const Color(0xff2C2C2C),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text('Booking Details'.tr,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: file != null
          ? PDFView(filePath: file!.path)
          : isloading
              ? const Center(child: CircularProgressIndicator(color: Color(0xff7D2AFF)),)
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 0);
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: data1!.tickethistory.length,
                          itemBuilder: (BuildContext context, int index) {

                            // var date1 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busPicktime));
                            // var date2 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busDroptime));

                            return Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Booking_Details(ticket_id: data1!.tickethistory[index].ticketId,),));
                                },
                                child: Container(
                                  // height: 200,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  margin: const EdgeInsets.only(bottom: 0),
                                  decoration: BoxDecoration(
                                    color: notifier.containercoloreproper,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Row(
                                            children: [
                                              const Image(
                                                  image: AssetImage('assets/Rectangle_2.png'), height: 40),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      // color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              65),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              '${config().baseUrl}/${data1?.tickethistory[index].busImg}'),
                                                          fit: BoxFit.fill))),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${data1?.tickethistory[index].busName}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: notifier
                                                              .textColor)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (data1
                                                              ?.tickethistory[
                                                                  index]
                                                              .isAc ==
                                                          '1')
                                                        Text('AC Seater'.tr,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: notifier
                                                                    .textColor)),
                                                      // if(data1?.tickethistory[index]. == '1') const Text('/ Sleeper  '),
                                                      // Text('${data1.busData[index].totlSeat} Seat',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                    ],
                                                  )
                                                  // const Text('Economy'),
                                                ],
                                              ),
                                              const Spacer(),
                                              // const Text('Available',style: TextStyle(color: Colors.green,fontSize: 13),),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                '$searchbus${data1?.tickethistory[0].subtotal}',
                                                style: const TextStyle(
                                                    color: Color(0xff7D2AFF),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          data1!
                                                              .tickethistory[
                                                                  index]
                                                              .boardingCity,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: notifier
                                                                  .textColor),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                          convertTimeTo12HourFormat(
                                                              data1!
                                                                  .tickethistory[
                                                                      index]
                                                                  .busPicktime),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff7D2AFF)),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      // Text(_selectedDate.toString().split(" ").first,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                      // const SizedBox(height: 8,),
                                                      // Text('Seat : ${data.busData[index].totlSeat}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // const Spacer(),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  const Image(
                                                      image: AssetImage(
                                                          'assets/Auto Layout Horizontal.png'),
                                                      height: 50,
                                                      width: 120,
                                                      color: Color(0xff7D2AFF)),
                                                  Text(
                                                      '${data1?.tickethistory[index].differencePickDrop}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: notifier
                                                              .textColor)),
                                                ],
                                              ),
                                              // const Spacer(),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          '${data1?.tickethistory[index].dropCity}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: notifier
                                                                  .textColor),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                          convertTimeTo12HourFormat(
                                                              data1!
                                                                  .tickethistory[
                                                                      index]
                                                                  .busDroptime),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff7D2AFF)),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      // Text('${_selectedDate.toString().split(" ").first}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                      // const SizedBox(height: 8,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      const SizedBox(height: 10,),
                      Container(
                        // height: 120,
                        width: MediaQuery.of(context).size.width,
                        color: notifier.containercoloreproper,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              data1!.tickethistory[0]
                                                  .subPickPlace,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: notifier.textColor)),
                                          Text(
                                              data1!.tickethistory[0]
                                                  .boardingCity,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: notifier.textColor)),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            height: 15,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // color: Colors.black,
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                      onTap: () {
                                                        // _makingPhoneCall(data1!.tickethistory[0].subPickMobile.toString().split(",").last);
                                                        _makingPhoneCall(
                                                            numbers[index]);

                                                        // _makingPhoneCall();
                                                      },
                                                      child: Text(
                                                          numbers[index],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .lightBlue)));
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const Text(
                                                    "-",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.lightBlue),
                                                  );
                                                },
                                                itemCount: numbers.length),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              convertTimeTo12HourFormat(data1!
                                                  .tickethistory[0]
                                                  .busPicktime),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: notifier.textColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const Spacer(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    children: [
                                      Image(
                                        image: AssetImage('assets/Group 3.png'),
                                        width: 20,
                                        height: 80,
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              data1!.tickethistory[0]
                                                  .subDropPlace,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: notifier.textColor)),
                                          Text(data1!.tickethistory[0].dropCity,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: notifier.textColor)),
                                          const SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                              convertTimeTo12HourFormat(data1!
                                                  .tickethistory[0]
                                                  .subDropTime),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: notifier.textColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: notifier.containercoloreproper,
                          // borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Image(
                                      image:
                                          AssetImage('assets/Rectangle_2.png'),
                                      height: 40),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Bus Details'.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: notifier.textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Booking Date'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                            '${data1?.tickethistory[0].bookDate.toString().split(' ').first}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Payment Methode'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                            '${data1?.tickethistory[0].pMethodName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Transaction Id'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                            '${data1?.tickethistory[0].transactionId}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Ticket Id'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                            '${data1?.tickethistory[0].ticketId}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: notifier.containercoloreproper,
                          // borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Image(
                                      image:
                                          AssetImage('assets/Rectangle_2.png'),
                                      height: 40),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Passenger(S)'.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: notifier.textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Table(
                                      // border: TableBorder.all(),
                                      columnWidths: const <int,
                                          TableColumnWidth>{
                                        0: FixedColumnWidth(250),
                                        1: FixedColumnWidth(40),
                                        2: FixedColumnWidth(40),
                                        3: FixedColumnWidth(40),
                                      },
                                      children: <TableRow>[
                                        TableRow(
                                          children: <Widget>[
                                            Text('Name'.tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: notifier.textColor)),
                                            Center(
                                                child: Text('Age'.tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: notifier
                                                            .textColor))),
                                            Center(
                                                child: Text('Seat'.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: notifier.textColor))),
                                            // Text('',style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        for (int a = 0; a < data1!.tickethistory[0].orderProductData.length; a++)
                                          TableRow(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                    '${data1?.tickethistory[0].orderProductData[a].name} (${data1?.tickethistory[0].orderProductData[a].gender})',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: notifier
                                                            .textColor)),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Center(
                                                    child: Text(
                                                        '${data1?.tickethistory[0].orderProductData[a].age}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color: notifier
                                                                .textColor))),
                                              ),
                                              // Text(widget.DataStore[index]["Age"],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Center(
                                                    child: Text(
                                                        '${data1?.tickethistory[0].orderProductData[a].seatNo}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color: notifier
                                                                .textColor))),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(top: 15),
                                              //   child: InkWell(
                                              //       onTap: () {
                                              //         Navigator.pop(context);
                                              //       },
                                              //       child: const Image(image: AssetImage('assets/editIcon.png'),height: 25,width: 25)),
                                              // ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: notifier.containercoloreproper,
                          // borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Image(
                                      image:
                                          AssetImage('assets/Rectangle_2.png'),
                                      height: 40),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Contact Details'.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: notifier.textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Full Name'.tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                            '${data1?.tickethistory[0].contactName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Email'.tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                            '${data1?.tickethistory[0].contactEmail}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Phone Number'.tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                            '${data1?.tickethistory[0].contactMobile}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      data1!.tickethistory[0].driverName.isEmpty && data1!.tickethistory[0].driverMobile.isEmpty && data1!.tickethistory[0].busNo.isEmpty ? const SizedBox() : Container(
                              // height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: notifier.containercoloreproper,
                                // borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Image(
                                            image: AssetImage(
                                                'assets/Rectangle_2.png'),
                                            height: 40),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Driver Details',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: notifier.textColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('Driver Name',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          notifier.textColor)),
                                              const Spacer(),
                                              Text(
                                                  '${data1?.tickethistory[0].driverName}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color:
                                                          notifier.textColor)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Text('Driver Number',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          notifier.textColor)),
                                              const Spacer(),
                                              Text(
                                                  '${data1?.tickethistory[0].driverMobile}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color:
                                                          notifier.textColor)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Text('Bus Number',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          notifier.textColor)),
                                              const Spacer(),
                                              Text(
                                                  '${data1?.tickethistory[0].busNo}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color:
                                                          notifier.textColor)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(height: 10,),
                      Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: notifier.containercoloreproper,
                          // borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Image(
                                      image:
                                          AssetImage('assets/Rectangle_2.png'),
                                      height: 40),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text('Price Details'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: notifier.textColor)),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Price'.tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                          '$searchbus ${data1?.tickethistory[0].subtotal}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: notifier.textColor),
                                        ),
                                      ],
                                    ),
                                    // light ? const SizedBox(height: 15,) : const SizedBox(height: 0,),
                                    // light ? switchcommoncode(): const SizedBox(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            'Tax(${data1?.tickethistory[0].taxAmt}%)',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        Text(
                                          '$searchbus $totalPayment',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: notifier.textColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Discount'.tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                                        Text(
                                          '$searchbus ${data1?.tickethistory[0].couAmt}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Wallet'.tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                                        Text(
                                          '$searchbus ${data1?.tickethistory[0].wallAmt}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Divider(
                                        color: Colors.grey.withOpacity(0.4)),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text('Total Price'.tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: notifier.textColor)),
                                        const Spacer(),
                                        // Text('${widget.currency} ${(totalAmount - coupon ) - walet} ',style: const TextStyle(fontWeight: FontWeight.bold),),
                                        Text(
                                          '$searchbus ${data1?.tickethistory[0].total} ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: notifier.textColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filepath'];
  }

  Future _capturePng() async {
    try {
      await [Permission.storage].request();
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      //create file
      final String dir = (await getApplicationDocumentsDirectory()).path;
      imagePath = '$dir/file_name${DateTime.now()}.png';
      capturedFile = File(imagePath);
      await capturedFile.writeAsBytes(pngBytes);
      print(capturedFile!.path);
      final result = await ImageGallerySaver.saveImage(pngBytes!,
          quality: 60, name: "file_name${DateTime.now()}");
      print(result);
      print('png done');
      // showToastMessage("Image saved in gallery");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image saved in gallery'.tr),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

//   Future _capturePng() async {
//     try {
//       await [Permission.storage].request();
//       print('inside');
//       RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List? pngBytes = byteData?.buffer.asUint8List();
// //create file
//       final String dir = (await getApplicationDocumentsDirectory()).path;
//       imagePath = '$dir/file_name${DateTime.now()}.png';
//       capturedFile = File(imagePath!);
//       await capturedFile.writeAsBytes(pngBytes);
//       // print(capturedFile!.path);
//       final result = await ImageGallerySaver.saveImage(pngBytes!,
//           quality: 60, name: "file_name${DateTime.now()}");
//       print(result);
//       print('png done');
//       // showToastMessage("Image saved in gallery");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image saved in gallery'),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
//       );
//       return pngBytes;
//     } catch (e) {
//       print(e);
//     }
//   }

  // Future<Directory> getApplicationDocumentsDirectory() async {
  //   final String? path = await _platform.getApplicationDocumentsPath();
  //   if (path == null) {
  //     throw MissingPlatformDirectoryException(
  //         'Unable to get application documents directory');
  //   }
  //   return Directory(path);
  // }

//
}

