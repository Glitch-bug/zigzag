// ignore_for_file: unnecessary_import

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:zigzag/config/config.dart';

import '../Sub_Screen/search_bus_screen.dart';

Future<Uint8List> makePdf({data1, searchbus, totalPayment}) async {
  final pdf = Document();

  final netImage = await networkImage('${config().baseUrl}${data1?.tickethistory[0].busImg}');
  final imageLogo = MemoryImage((await rootBundle.load('assets/Group 3.png')).buffer.asUint8List());
  final imageLogo1 = MemoryImage((await rootBundle.load('assets/Auto Layout Horizontal.png')).buffer.asUint8List());
  final imageLogo2 = MemoryImage((await rootBundle.load('assets/Rectangle_2.png')).buffer.asUint8List());

  pdf.addPage(MultiPage(
    // pageFormat: PdfPageFormat.legal,
    build: (context) {
      return [
        Column(children: [
          SizedBox(height: 10,),
          ListView.builder(
              // separatorBuilder: (context, index) {
              //   return SizedBox(height: 0);
              // },
              // shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              itemCount: data1!.tickethistory.length,
              itemBuilder: (context, int index) {
                // var date1 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busPicktime));
                // var date2 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busDroptime));

                return Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    // height: 200,
                    // width: MediaQuery.of(context).size.width*0.8,
                    margin: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              children: [

                                      Image(imageLogo2,height: 40),

                                Padding(padding: const EdgeInsets.only(left: 10),child: Container(
                                    height: 45,
                                    width: 45,
                                    child: ClipRRect(
                                        horizontalRadius: 25,
                                        verticalRadius: 20,
                                        child: Image(netImage, fit: BoxFit.fill)),
                                    decoration: const BoxDecoration(
                                      // color: PdfColors.red,
                                      // borderRadius: BorderRadius.circular(20),
                                      shape: BoxShape.circle,
                                    )
                                  // decoration:BoxDecoration(
                                  //     // color: Colors.red,
                                  //     borderRadius:BorderRadius.circular(65),
                                  //     image: DecorationImage(
                                  //       image: Image(netImage),
                                  //     )
                                  //     // image:DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.tickethistory[index].busImg}'),fit:BoxFit.fill))
                                  //     // image:DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.tickethistory[index].busImg}'),fit:BoxFit.fill))
                                  // ),
                                ),),
                                SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${data1?.tickethistory[index].busName}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        if (data1?.tickethistory[index].isAc ==
                                            '1')
                                          Text('AC Seater '.tr),
                                        // if(data.busData[index].isSleeper == '1') const Text('/ Sleeper  '),
                                        // Text('${data.busData[index].totlSeat} Seat',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                      ],
                                    )
                                    // const Text('Economy'),
                                  ],
                                ),
                                Spacer(),
                                // const Text('Available',style: TextStyle(color: Colors.green,fontSize: 13),),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '$searchbus${data1?.tickethistory[0].total}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      data1!.tickethistory[index].boardingCity,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      convertTimeTo12HourFormat(data1!
                                          .tickethistory[index].busPicktime),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // Text(_selectedDate.toString().split(" ").first,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    // const SizedBox(height: 8,),
                                    // Text('Seat : ${data.busData[index].totlSeat}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Image(imageLogo1,height: 50,width: 140),

                                    Text('${data1?.tickethistory[index].differencePickDrop}'),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${data1?.tickethistory[index].dropCity}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      convertTimeTo12HourFormat(data1!
                                          .tickethistory[index].busDroptime),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
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

          SizedBox(height: 10,),
          Container(
            // height: 120,
            // width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Text(data1!.tickethistory[0].subPickPlace, style: const TextStyle(fontSize: 16)),
                          Text(data1!.tickethistory[0].boardingCity, style: const TextStyle(fontSize: 16)),
                          SizedBox(height: 13,),
                          Text(convertTimeTo12HourFormat(data1!.tickethistory[0].busPicktime), style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Image(imageLogo,width: 20,height: 80,),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(data1!.tickethistory[0].subDropPlace,
                              style: const TextStyle(fontSize: 16)),
                          Text(data1!.tickethistory[0].dropCity,
                              style: const TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                              convertTimeTo12HourFormat(
                                  data1!.tickethistory[0].subDropTime),
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          SizedBox(height: 10,),
          Container(
            // height: 200,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                // color: Colors.white,
                // borderRadius: BorderRadius.circular(20),
                ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image(imageLogo2,height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Bus Details'.tr,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Bokking Date'.tr),
                            Spacer(),
                            Text(
                                '${data1?.tickethistory[0].bookDate.toString().split(' ').first}'),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Payment Methode'.tr),
                            Spacer(),
                            Text('${data1?.tickethistory[0].pMethodName}'),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Transaction Id'.tr),
                            Spacer(),
                            Text('${data1?.tickethistory[0].transactionId}'),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Ticket Id'.tr),
                            Spacer(),
                            Text('${data1?.tickethistory[0].ticketId}'),
                          ],
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Row(
                        //   children: [
                        //     Text('Bus Number'.tr),
                        //     Spacer(),
                        //     Text('${data1?.tickethistory[0].busNo}'),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            // height: 200,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                // color: Colors.white,
                // borderRadius: BorderRadius.circular(20),
                ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image(imageLogo2,height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Passenger(S)'.tr,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Table(
                          // border:TableBorder.all(),
                          columnWidths: <int, TableColumnWidth>{
                            0: const FixedColumnWidth(250),
                            1: const FixedColumnWidth(40),
                            2: const FixedColumnWidth(40),
                            3: const FixedColumnWidth(40),
                          },
                          children: <TableRow>[
                            TableRow(
                              children: <Widget>[
                                Text(
                                  'Name'.tr,
                                ),
                                Center(child: Text('Age'.tr)),
                                Center(child: Text('Seat'.tr)),
                                // Text('',style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            for (int a = 0;
                                a <
                                    data1!.tickethistory[0].orderProductData
                                        .length;
                                a++)
                              TableRow(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                        '${data1?.tickethistory[0].orderProductData[a].name} (${data1?.tickethistory[0].orderProductData[a].gender})'),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Center(
                                        child: Text(
                                      '${data1?.tickethistory[0].orderProductData[a].age}',
                                    )),
                                  ),
                                  // Text(widget.DataStore[index]["Age"],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Center(
                                        child: Text(
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
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            // height: 200,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                // color: Colors.white,
                // borderRadius: BorderRadius.circular(20),
                ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image(imageLogo2,height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Contact Details'.tr),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Full Name'.tr),
                            Spacer(),
                            Text(
                              '${data1?.tickethistory[0].contactName}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Email'.tr),
                            Spacer(),
                            Text(
                              '${data1?.tickethistory[0].contactEmail}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Phone Number'.tr),
                            Spacer(),
                            Text('${data1?.tickethistory[0].contactMobile}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          data1!.tickethistory[0].driverName.isEmpty && data1!.tickethistory[0].driverMobile.isEmpty && data1!.tickethistory[0].busNo.isEmpty ? SizedBox() : Container(
                  // height: 200,
                  // width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      // color: Colors.white,
                      // borderRadius: BorderRadius.circular(20),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image(imageLogo2,height: 40),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Driver Details'.tr,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Driver Name'.tr),
                                  Spacer(),
                                  Text(
                                    '${data1?.tickethistory[0].driverName}',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text('Driver Number'.tr),
                                  Spacer(),
                                  Text(
                                    '${data1?.tickethistory[0].driverMobile}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
          SizedBox(height: 10,),
          Container(
            // height: 200,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                // color: Colors.white,
                // borderRadius: BorderRadius.circular(20),
                ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image(imageLogo2,height: 40),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Price Details'.tr,
                          style: const TextStyle(fontSize: 17)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Price'.tr),
                            Spacer(),
                            Text(
                              '$searchbus ${data1?.tickethistory[0].subtotal}',
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        // light ? const SizedBox(height: 15,) : const SizedBox(height: 0,),
                        // light ? switchcommoncode(): const SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Tax(${data1?.tickethistory[0].taxAmt}%)'),
                            Spacer(),
                            Text(
                              '$searchbus $totalPayment',
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Discount'.tr),
                            Spacer(),
                            // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                            Text(
                              '$searchbus ${data1?.tickethistory[0].couAmt}',
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Wallet'.tr),
                            Spacer(),
                            // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                            Text(
                              '$searchbus ${data1?.tickethistory[0].wallAmt}',
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('Total Price'.tr),
                            Spacer(),
                            // Text('${widget.currency} ${(totalAmount - coupon ) - walet} ',style: const TextStyle(fontWeight: FontWeight.bold),),
                            Text(
                              '$searchbus ${data1?.tickethistory[0].total} ',
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
        ])
      ];
    },
  )

      // Page(
      //   build: (context) {
      //     return Column(
      //       children: [
      //        SizedBox(height: 10,),
      //
      //
      //        ListView.builder(
      //           // separatorBuilder: (context, index) {
      //           //   return SizedBox(height: 0);
      //           // },
      //           // shrinkWrap: true,
      //           // scrollDirection: Axis.vertical,
      //             itemCount: data1!.tickethistory.length,
      //             itemBuilder: (context, int index) {
      //
      //               // var date1 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busPicktime));
      //               // var date2 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busDroptime));
      //
      //               return Padding(
      //                 padding:  const EdgeInsets.only(top: 0),
      //                 child:Container(
      //                   // height: 200,
      //                   // width: MediaQuery.of(context).size.width*0.8,
      //                   margin: const EdgeInsets.only(bottom: 0),
      //                   decoration:BoxDecoration(
      //                     // color: Colors.white,
      //                     borderRadius:BorderRadius.circular(0),
      //                   ),
      //                   child: Padding(
      //                     padding:  EdgeInsets.only(top: 15,bottom: 15),
      //                     child:Column(
      //                       children: [
      //                        Padding(
      //                           padding: const EdgeInsets.only(right: 15),
      //                           child:Row(
      //                             children: [
      //
      //                               Container(
      //                                   height: 35,
      //                                   width: 35,
      //                                   child: Image(netImage),
      //                                   // decoration:BoxDecoration(
      //                                   //     // color: Colors.red,
      //                                   //     borderRadius:BorderRadius.circular(65),
      //                                   //     image: DecorationImage(
      //                                   //       image: Image(netImage),
      //                                   //     )
      //                                   //     // image:DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.tickethistory[index].busImg}'),fit:BoxFit.fill))
      //                                   //     // image:DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.tickethistory[index].busImg}'),fit:BoxFit.fill))
      //                                   // ),
      //                               ),
      //                               SizedBox(width: 15,),
      //                              Column(
      //                                 crossAxisAlignment:CrossAxisAlignment.start,
      //                                 children: [
      //                                  Text('${data1?.tickethistory[index].busName}',style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold,)),
      //                                   SizedBox(height: 5,),
      //                                  Row(
      //                                     children: [
      //                                       if(data1?.tickethistory[index].isAc == '1') Text('AC Seater '.tr),
      //                                       // if(data.busData[index].isSleeper == '1') const Text('/ Sleeper  '),
      //                                       // Text('${data.busData[index].totlSeat} Seat',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //                                     ],
      //                                   )
      //                                   // const Text('Economy'),
      //                                 ],
      //                               ),
      //                               Spacer(),
      //                               // const Text('Available',style: TextStyle(color: Colors.green,fontSize: 13),),
      //                               SizedBox(width: 4,),
      //                              Text('${searchbus}${data1?.tickethistory[0].total}',style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold),),
      //                             ],
      //                           ),
      //                         ),
      //                         SizedBox(height: 15,),
      //                        Padding(
      //                           padding: const EdgeInsets.only(left: 15,right: 15),
      //                           child:Row(
      //                             children: [
      //                              Column(
      //                                 crossAxisAlignment:CrossAxisAlignment.start,
      //                                 mainAxisAlignment:MainAxisAlignment.start,
      //                                 children: [
      //                                  Text(data1!.tickethistory[index].boardingCity,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
      //                                   SizedBox(height: 8,),
      //                                  Text(convertTimeTo12HourFormat(data1!.tickethistory[index].busPicktime),style: TextStyle(fontWeight:FontWeight.bold,),),
      //                                   SizedBox(height: 8,),
      //                                   // Text(_selectedDate.toString().split(" ").first,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //                                   // const SizedBox(height: 8,),
      //                                   // Text('Seat : ${data.busData[index].totlSeat}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
      //                                 ],
      //                               ),
      //                               Spacer(),
      //                              Column(
      //                                 children: [
      //                                   //Image(image: AssetImage('${image1}'),height: 50,width: 140),
      //
      //                                  Text('${data1?.tickethistory[index].differencePickDrop}'),
      //                                 ],
      //                               ),
      //                               Spacer(),
      //                              Column(
      //                                 crossAxisAlignment:CrossAxisAlignment.end,
      //                                 mainAxisAlignment:MainAxisAlignment.end,
      //                                 children: [
      //                                  Text('${data1?.tickethistory[index].dropCity}',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
      //                                   SizedBox(height: 8,),
      //                                  Text(convertTimeTo12HourFormat(data1!.tickethistory[index].busDroptime),style: TextStyle(fontWeight: FontWeight.bold),),
      //                                   SizedBox(height: 8,),
      //                                   // Text('${_selectedDate.toString().split(" ").first}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //                                   // const SizedBox(height: 8,),
      //                                 ],
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             }
      //         ),
      //        SizedBox(height: 10,),
      //        Container(
      //           // height: 120,
      //           // width: MediaQuery.of(context).size.width,
      //           // color: Colors.white,
      //           child:Column(
      //             mainAxisAlignment:MainAxisAlignment.start,
      //             crossAxisAlignment:CrossAxisAlignment.start,
      //             children: [
      //               SizedBox(height: 10,),
      //              Padding(
      //                 padding: const EdgeInsets.only(left:15,right: 15),
      //                 child:Row(
      //                   children: [
      //                    Column(
      //                       crossAxisAlignment:CrossAxisAlignment.start,
      //                       children: [
      //                        Text(data1!.tickethistory[0].subPickPlace,style: const TextStyle(fontSize: 16)),
      //                        Text(data1!.tickethistory[0].boardingCity,style: const TextStyle(fontSize: 16)),
      //                         SizedBox(height: 13,),
      //                        Text(convertTimeTo12HourFormat(data1!.tickethistory[0].busPicktime),style: const TextStyle(fontSize: 12)),
      //                       ],
      //                     ),
      //                     Spacer(),
      //                     // Column(
      //                     //   children: [
      //                     //     Image(image: AssetImage('assets/Group 3.png'),width: 20,height: 80,),
      //                     //   ],
      //                     // ),
      //                     Spacer(),
      //                    Column(
      //                       crossAxisAlignment:CrossAxisAlignment.end,
      //                       children: [
      //                        Text(data1!.tickethistory[0].subDropPlace,style: const TextStyle(fontSize: 16)),
      //                        Text(data1!.tickethistory[0].dropCity,style: const TextStyle(fontSize: 16)),
      //                         SizedBox(height: 13,),
      //                        Text(convertTimeTo12HourFormat(data1!.tickethistory[0].subDropTime),style: const TextStyle(fontSize: 12)),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(height: 10,),
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 10,),
      //
      //         Container(
      //           // height: 200,
      //           // width: MediaQuery.of(context).size.width,
      //           decoration: const BoxDecoration(
      //             // color: Colors.white,
      //             // borderRadius: BorderRadius.circular(20),
      //           ),
      //           child:  Padding(
      //             padding: const EdgeInsets.all(0),
      //             child:Column(
      //               crossAxisAlignment:CrossAxisAlignment.start,
      //               children: [
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   children: [
      //                     // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
      //                    SizedBox(width: 15,),
      //                    Text('Bus Details'.tr,style: const TextStyle(fontSize: 17),),
      //                   ],
      //                 ),
      //                 SizedBox(height: 20,),
      //                Padding(
      //                   padding: const EdgeInsets.only(left: 15,right: 15),
      //                   child:Column(
      //                     children: [
      //                      Row(
      //                         children: [
      //                           Text('Bokking Date'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].bookDate.toString().split(' ').first}'),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Payment Methode'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].pMethodName}'),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Transaction Id'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].transactionId}'),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Ticket Id'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].ticketId}'),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Bus Number'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].busNo}'),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 10,),
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 10,),
      //
      //        Container(
      //           // height: 200,
      //           // width: MediaQuery.of(context).size.width,
      //           decoration: const BoxDecoration(
      //             // color: Colors.white,
      //             // borderRadius: BorderRadius.circular(20),
      //           ),
      //           child:Padding(
      //             padding: const EdgeInsets.all(0),
      //             child:Column(
      //               crossAxisAlignment:CrossAxisAlignment.start,
      //               children: [
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   children: [
      //                     // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
      //                    SizedBox(width: 15,),
      //                    Text('Passenger(S)'.tr,style: const TextStyle(fontSize: 17),),
      //                   ],
      //                 ),
      //                 SizedBox(height: 20,),
      //                Padding(
      //                   padding: const EdgeInsets.only(left: 15,right: 15),
      //                   child:Column(
      //                     children: [
      //                      Table(
      //                         // border:TableBorder.all(),
      //                         columnWidths: <int,TableColumnWidth>{
      //                           0: const FixedColumnWidth(250),
      //                           1: const FixedColumnWidth(40),
      //                           2: const FixedColumnWidth(40),
      //                           3: const FixedColumnWidth(40),
      //                         },
      //                         children: <TableRow>[
      //                          TableRow(
      //                             children: <Widget>[
      //                              Text('Name'.tr,),
      //                              Center(child:Text('Age'.tr)),
      //                              Center(child:Text('Seat'.tr)),
      //                               // Text('',style: TextStyle(fontWeight: FontWeight.bold)),
      //                             ],
      //                           ),
      //                           for(int a = 0; a<data1!.tickethistory[0].orderProductData.length; a++) TableRow(
      //                             children: <Widget>[
      //                              Padding(
      //                                 padding: const EdgeInsets.only(top: 15),
      //                                 child:Text('${data1?.tickethistory[0].orderProductData[a].name} (${data1?.tickethistory[0].orderProductData[a].gender})'),
      //                               ),
      //
      //                              Padding(
      //                                 padding: const EdgeInsets.only(top: 15),
      //                                 child:Center(child:Text('${data1?.tickethistory[0].orderProductData[a].age}',)),
      //                               ),
      //                               // Text(widget.DataStore[index]["Age"],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
      //                              Padding(
      //                                 padding: const EdgeInsets.only(top: 15),
      //                                 child:Center(child:Text('${data1?.tickethistory[0].orderProductData[a].seatNo}')),
      //                               ),
      //
      //                               // Padding(
      //                               //   padding: const EdgeInsets.only(top: 15),
      //                               //   child: InkWell(
      //                               //       onTap: () {
      //                               //         Navigator.pop(context);
      //                               //       },
      //                               //       child: const Image(image: AssetImage('assets/editIcon.png'),height: 25,width: 25)),
      //                               // ),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 10,),
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 10,),
      //        Container(
      //           // height: 200,
      //           // width: MediaQuery.of(context).size.width,
      //           decoration: const BoxDecoration(
      //             // color: Colors.white,
      //             // borderRadius: BorderRadius.circular(20),
      //           ),
      //           child: Padding(
      //             padding: const EdgeInsets.all(0),
      //             child:Column(
      //               crossAxisAlignment:CrossAxisAlignment.start,
      //               children: [
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   children: [
      //                     // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
      //                    SizedBox(width: 15,),
      //                    Text('Contact Details'.tr),
      //                   ],
      //                 ),
      //                 SizedBox(height: 20,),
      //                Padding(
      //                   padding: const EdgeInsets.only(left: 15,right: 15),
      //                   child:Column(
      //                     children: [
      //                      Row(
      //                         children: [
      //                           Text('Full Name'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].contactName}',),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Email'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].contactEmail}',),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Phone Number'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].contactMobile}'),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 10,),
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 10,),
      //         data1!.tickethistory[0].driverName.isEmpty && data1!.tickethistory[0].driverMobile.isEmpty && data1!.tickethistory[0].busNo.isEmpty ? SizedBox() : Container(
      //           // height: 200,
      //           // width: MediaQuery.of(context).size.width,
      //           decoration: BoxDecoration(
      //             // color: Colors.white,
      //             // borderRadius: BorderRadius.circular(20),
      //           ),
      //           child:  Padding(
      //             padding: EdgeInsets.all(0),
      //             child:Column(
      //               crossAxisAlignment:CrossAxisAlignment.start,
      //               children: [
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   children: [
      //                     // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
      //                     SizedBox(width: 15,),
      //                    Text('Driver Details'.tr,),
      //                   ],
      //                 ),
      //                 SizedBox(height: 20,),
      //                Padding(
      //                   padding: EdgeInsets.only(left: 15,right: 15),
      //                   child:Column(
      //                     children: [
      //                      Row(
      //                         children: [
      //                           Text('Driver Name'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].driverName}',),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Driver Number'.tr),
      //                           Spacer(),
      //                          Text('${data1?.tickethistory[0].driverMobile}',),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 10,),
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 10,),
      //        Container(
      //           // height: 200,
      //           // width: MediaQuery.of(context).size.width,
      //           decoration: const BoxDecoration(
      //             // color: Colors.white,
      //             // borderRadius: BorderRadius.circular(20),
      //           ),
      //           child: Padding(
      //             padding: const EdgeInsets.all(0),
      //             child:Column(
      //               crossAxisAlignment:CrossAxisAlignment.start,
      //               children: [
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   children: [
      //                     // Image(image: AssetImage('assets/Rectangle_2.png'),height: 40),
      //                     SizedBox(width: 15,),
      //                     Text('Price Details'.tr,style: const TextStyle(fontSize: 17)),
      //                   ],
      //                 ),
      //                Padding(
      //                   padding: const EdgeInsets.only(left: 15,right: 15),
      //                   child:Column(
      //                     children: [
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Price'.tr),
      //                           Spacer(),
      //                          Text('${searchbus} ${data1?.tickethistory[0].subtotal}',style: const TextStyle(),),
      //                         ],
      //                       ),
      //                       // light ? const SizedBox(height: 15,) : const SizedBox(height: 0,),
      //                       // light ? switchcommoncode(): const SizedBox(),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                          Text('Tax(${data1?.tickethistory[0].taxAmt}%)'),
      //                           Spacer(),
      //                          Text('${searchbus} ${totalPayment}',style: const TextStyle(),),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Discount'.tr),
      //                           Spacer(),
      //                           // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
      //                          Text('${searchbus} ${data1?.tickethistory[0].couAmt}',style: const TextStyle(),),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                      Row(
      //                         children: [
      //                           Text('Wallet'.tr),
      //                           Spacer(),
      //                           // Text('% ${coupon .toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
      //                          Text('${searchbus} ${data1?.tickethistory[0].wallAmt}',style: const TextStyle(),),
      //                         ],
      //                       ),
      //                       SizedBox(height: 8,),
      //                      Divider(),
      //                       SizedBox(height: 8,),
      //                      Row(
      //                         children: [
      //                           Text('Total Price'.tr),
      //                           Spacer(),
      //                           // Text('${widget.currency} ${(totalAmount - coupon ) - walet} ',style: const TextStyle(fontWeight: FontWeight.bold),),
      //                          Text('${searchbus} ${data1?.tickethistory[0].total} ',style: const TextStyle(),),
      //                         ],
      //                       ),
      //                       SizedBox(height: 15,),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 20,),
      //       ]
      //     );
      //
      //   },
      // ),
      );
  return pdf.save();
}


//google assinte
