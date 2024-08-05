// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_import, unused_field, must_be_immutable, use_super_parameters, prefer_final_fields, avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Common_Code/common_button.dart';
import '../config/light_and_dark.dart';
import 'user_payment_screen.dart';

enum SingingCharacter { lafayette, jefferson }

class Passenger_Information extends StatefulWidget {
  final String busTitle;
  final String selectIndex;
  final String selectIndex1;
  final String to;
  final String from;
  final int length;
  final List selectset;
  final List selectset1;
  final num bottom;
  final String busImg;
  final String ticketPrice;
  final String boardingCity;
  final String dropCity;
  final String busPicktime;
  final String busDroptime;
  final String uid;
  final String wallet;
  final String trip_date;
  final String busAc;
  final String isSleeper;
  final String totlSeat;
  final String differencePickDrop;
  final String currency;
  final String bus_id;
  final String pick_id;
  final String dropId;
  final String boarding_id;
  final String drop_id;
  final String Difference_pick_drop;
  final String pick_time;
  final String pickTime;
  final String pick_place;
  final String pick_address;
  final String pick_mobile;
  final String dropTime;
  final String drop_time;
  final String drop_place;
  final String drop_address;
  final String pickMobile;

  const Passenger_Information(
      {Key? key,
      required this.busTitle,
      required this.selectIndex,
      required this.selectIndex1,
      required this.to,
      required this.from,
      required this.length,
      required this.selectset,
      required this.selectset1,
      required this.bottom,
      required this.busImg,
      required this.ticketPrice,
      required this.boardingCity,
      required this.dropCity,
      required this.busPicktime,
      required this.busDroptime,
      required this.uid,
      required this.pickTime,
      required this.dropTime,
      required this.wallet,
      required this.trip_date,
      required this.busAc,
      required this.isSleeper,
      required this.totlSeat,
      required this.differencePickDrop,
      required this.currency,
      required this.bus_id,
      required this.pick_id,
      required this.dropId,
      required this.boarding_id,
      required this.drop_id,
      required this.Difference_pick_drop,
      required this.pick_place,
      required this.pick_address,
      required this.pick_mobile,
      required this.drop_place,
      required this.drop_address,
      required this.pick_time,
      required this.drop_time,
      required this.pickMobile})
      : super(key: key);

  @override
  State<Passenger_Information> createState() => _Passenger_InformationState();
}

class _Passenger_InformationState extends State<Passenger_Information> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController FullnameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  // List dilogboxlist = [
  //   'India',
  //   'Indonesia',
  //   'Singapore',
  //   'Malaysia',
  //   'Peru',
  //   'Colombia',
  //   'Afghanistan',
  //   'Albania',
  //   'Algeria',
  //   'Americal Samoa',
  //   'Andorra',
  //   'Angola',
  //   'Anguilla',
  //   'Norfolk Island',
  //   'Antigua',
  // ];

  List NameController = [];
  List ageController = [];

  List DataStore = [];

  List<DynamicWidget> listDynamic = [];
  List<DynamicWidget1> listDynamicage = [];

  bool light = true;
  bool light1 = false;
  bool light2 = false;

  SingingCharacter? _character = SingingCharacter.lafayette;

  // List Passenger = [
  //   'Passenger 1',
  //   'Passenger 2',
  //   'Passenger 3',
  //   'Passenger 4',
  //   'Passenger 5',
  // ];

  List siteNumber = [];
  List manadf = [];

  @override
  void initState() {
    super.initState();

    print(widget.selectset1);
    print(widget.selectset);
    print(
        "////////////////////////1254638455///////////////////////////////////////////  ${widget.busPicktime}");

    for (int a = 0; a < widget.length; a++) {
      listDynamic.add(DynamicWidget());
      listDynamicage.add(DynamicWidget1());
    }

    setState(() {
      siteNumber = widget.selectset + widget.selectset1;
    });
  }

  int ma_fe = 0;

  // bool selectman = false;
  ColorNotifier notifier = ColorNotifier();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // height: 103,
            height: 115,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: notifier.containercoloreproper,
                border: Border.all(color: Colors.grey.withOpacity(0.4))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Amount :'.tr,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: notifier.textColor),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              // const Image(image: AssetImage('assets/ruppe_image.png'),color: Color(0xff7D2AFF),height: 15,width: 15,),
                              // const SizedBox(width: 5,),
                              Text(
                                '${widget.currency} ${widget.bottom}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff7D2AFF)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '(Exclusive of Taxes)'.tr,
                                style: TextStyle(
                                    fontSize: 10, color: notifier.textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          // Image(image: AssetImage('assets/plus-square.png')),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      submitData();
                      submitData1();
                      print("-+-+-+-+-+-1 2 3 4 5+-+-+--+-+-+-+-+-${data[0]}");
                      // print("-+-+-+-+-+-+-+-+--++-++-+-${manadf.length}");
                      print(
                          "-+-+-+-+-+-+6 7 8 9 10-+-+--++-++-+-${listDynamic.length}");
                      print(
                          "-+-+-+-+-+-+11 12 13 14 15-+-+--+-+-+-+-+-${listDynamicage}");

                      if (widget.length == manadf.length &&
                          listDynamic.length == widget.length &&
                          listDynamicage.length == widget.length) {
                        if (mobileController.text.isEmpty ||
                            EmailController.text.isEmpty ||
                            FullnameController.text.isEmpty ||
                            manadf.isEmpty ||
                            listDynamic.isEmpty ||
                            listDynamicage.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Enter Plese Input'.tr),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Payment_Screen(
                                    pickMobile: widget.pickMobile,
                                    drop_time: widget.drop_time,
                                    pick_time: widget.pick_time,
                                    pick_mobile: widget.pick_mobile,
                                    pick_address: widget.pick_address,
                                    pick_place: widget.pick_place,
                                    dropTime: widget.dropTime,
                                    pickTime: widget.dropTime,
                                    drop_address: widget.drop_address,
                                    drop_place: widget.drop_place,
                                    Difference_pick_drop:
                                        widget.differencePickDrop,
                                    boarding_id: widget.boarding_id,
                                    drop_id: widget.drop_id,
                                    manadf: manadf,
                                    siteNumber: siteNumber,
                                    listDynamicage: listDynamicage,
                                    listDynamic: listDynamic,
                                    trip_date: widget.trip_date,
                                    dropId: widget.dropId,
                                    pick_id: widget.pick_id,
                                    bus_id: widget.bus_id,
                                    currency: widget.currency,
                                    busAc: widget.busAc,
                                    differencePickDrop:
                                        widget.differencePickDrop,
                                    totlSeat: widget.totlSeat,
                                    isSleeper: widget.isSleeper,
                                    data: data,
                                    data1: data1,
                                    ma_fe: manadf,
                                    wallet: widget.wallet,
                                    bottom: widget.bottom,
                                    selectIndex: widget.selectIndex,
                                    selectIndex1: widget.selectIndex1,
                                    DataStore: DataStore,
                                    uid: widget.uid,
                                    EmailController: EmailController.text,
                                    FullnameController: FullnameController.text,
                                    mobileController: mobileController.text,
                                    busPicktime: widget.busPicktime,
                                    busDroptime: widget.busDroptime,
                                    boardingCity: widget.boardingCity,
                                    dropCity: widget.dropCity,
                                    ticketPrice: widget.ticketPrice,
                                    busImg: widget.busImg,
                                    busTitle: widget.busTitle,
                                    selectset: widget.selectset,
                                    selectset1: widget.selectset1),
                              ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Enter Plese Input'.tr),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: CommonButton(
                          containcolore: const Color(0xff7D2AFF),
                          txt1: 'PROCEED'.tr,
                          context: context),
                    )),
              ],
            ),
          ),
          // Text("$bottom",style: TextStyle(color: Colors.red)),
        ],
      ),
      // backgroundColor: const Color(0xffF5F5F5),
      backgroundColor: notifier.backgroundgray,
      // backgroundColor:  Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        backgroundColor: const Color(0xff2C2C2C),
        title: Transform.translate(
          offset: const Offset(-15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.boardingCity}  to  ${widget.dropCity}',
                  style: const TextStyle(color: Colors.white, fontSize: 13)),
              const SizedBox(
                height: 5,
              ),
              Text(widget.trip_date.toString().split(" ").first,
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              // height: 120,
              width: MediaQuery.of(context).size.width,
              color: notifier.containercoloreproper,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(15),
                  //   child: Row(
                  //     children: [
                  //       const Icon(Icons.bus_alert_outlined,color: Colors.red,),
                  //       const SizedBox(width: 10,),
                  //       Text(widget.busTitle,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.selectIndex,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: notifier.textColor)),
                                Text(widget.from,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: notifier.textColor)),
                                const SizedBox(
                                  height: 13,
                                ),
                                Text(widget.pickTime,
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
                          height: 10,
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
                          height: 10,
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.selectIndex1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: notifier.textColor)),
                                Text(widget.to,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: notifier.textColor)),
                                const SizedBox(
                                  height: 13,
                                ),
                                Text(widget.dropTime,
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
            const SizedBox(
              height: 10,
            ),
            Container(
              // height: 120,
              width: MediaQuery.of(context).size.width,
              color: notifier.containercoloreproper,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Image(
                          image: AssetImage('assets/Rectangle_2.png'),
                          height: 40),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, bottom: 10),
                        child: Text(
                          'Passenger Details'.tr,
                          style: TextStyle(
                              color: notifier.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                          height: 25,
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listDynamic.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text('Passenger ${index+1} || Seat ${siteNumber[index]}',style:  TextStyle(fontSize: 13,color: notifier.textColor),maxLines: 1),
                                        Row(
                                          children: [
                                            Text('Passenger'.tr,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: notifier.textColor),
                                                maxLines: 1),
                                            Text(' ${index + 1} || ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: notifier.textColor),
                                                maxLines: 1),
                                            Text('Seats'.tr,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: notifier.textColor),
                                                maxLines: 1),
                                            Text('-${siteNumber[index]}',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: notifier.textColor),
                                                maxLines: 1),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        listDynamic[index],
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Age'.tr,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: notifier.textColor),
                                            maxLines: 1),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        listDynamicage[index],
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Gender'.tr,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: notifier.textColor),
                                            maxLines: 1),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (manadf.contains(
                                                      "MALE-$index") ==
                                                  true) {
                                                manadf.remove("MALE-$index");
                                              } else {
                                                manadf.remove("FEMALE-$index");
                                                manadf.add("MALE-$index");
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  manadf.contains("MALE-$index")
                                                      ? const Color(0xff7D2AFF)
                                                      : Colors.grey
                                                          .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // image: DecorationImage(image: AssetImage('assets/Group.png'))
                                            ),
                                            child: const Center(
                                                child: Image(
                                              image: AssetImage(
                                                  'assets/Group.png'),
                                              height: 30,
                                              width: 30,
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (manadf.contains(
                                                      "FEMALE-$index") ==
                                                  true) {
                                                manadf.remove("FEMALE-$index");
                                              } else {
                                                manadf.remove("MALE-$index");
                                                manadf.add("FEMALE-$index");
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: manadf
                                                      .contains("FEMALE-$index")
                                                  ? const Color(0xff7D2AFF)
                                                  : Colors.grey
                                                      .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // image: DecorationImage(image: AssetImage('assets/Group1.png'))
                                            ),
                                            child: const Center(
                                                child: Image(
                                              image: AssetImage(
                                                  'assets/Group1.png'),
                                              height: 30,
                                              width: 30,
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }),

                  // ListView.separated(
                  //     separatorBuilder: (context, index) {
                  //       return const SizedBox(width: 15,);
                  //     },
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.vertical,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: widget.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 10,right: 10),
                  //             child: Row(
                  //               children: [
                  //                 Expanded(
                  //                   flex: 4,
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text('Passenger ${index+1}',style: TextStyle(fontSize: 15),maxLines: 1),
                  //                       SizedBox(height: 6,),
                  //                       listDynamic[index],
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(width: 8,),
                  //                 Expanded(
                  //                   flex: 2,
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text('Age',style: TextStyle(fontSize: 15),maxLines: 1),
                  //                       SizedBox(height: 6,),
                  //                       listDynamicage[index],
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 SizedBox(width: 8,),
                  //                 Expanded(
                  //                   flex: 1,
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text('Gender',style: TextStyle(fontSize: 15),maxLines: 1),
                  //                       SizedBox(height: 6,),
                  //                       InkWell(
                  //                         onTap: () {
                  //                           setState(() {
                  //                             if(manadf.contains("M-$index") ==  true){
                  //                               manadf.remove("M-$index");
                  //                             }else{
                  //                               manadf.remove("F-$index");
                  //                               manadf.add("M-$index");
                  //                             }
                  //                           });
                  //                         },
                  //                         child: Container(
                  //                           height: 40,
                  //                           width: 40,
                  //                           decoration: BoxDecoration(
                  //                             color: manadf.contains("M-$index") ? Colors.red : Colors.grey.withOpacity(0.4),
                  //                             borderRadius: BorderRadius.circular(10),
                  //                             // image: DecorationImage(image: AssetImage('assets/Group.png'))
                  //                           ),
                  //                           child: Center(child: Image(image: AssetImage('assets/Group.png'),height: 30,width: 30,)),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 const SizedBox(width: 8,),
                  //                 Expanded(
                  //                   flex: 1,
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text('',style: TextStyle(fontSize: 15),),
                  //                       SizedBox(height: 6,),
                  //                       InkWell(
                  //                         onTap: () {
                  //                           setState(() {
                  //                             if(manadf.contains("F-$index") ==  true){
                  //                               manadf.remove("F-$index");
                  //                             }else{
                  //                               manadf.remove("M-$index");
                  //                               manadf.add("F-$index");
                  //                             }
                  //                           });
                  //                         },
                  //                         child: Container(
                  //                           height: 40,
                  //                           width: 40,
                  //                           decoration: BoxDecoration(
                  //                             color:  manadf.contains("F-$index") ? Colors.red :Colors.grey.withOpacity(0.4),
                  //                             borderRadius: BorderRadius.circular(10),
                  //                             // image: DecorationImage(image: AssetImage('assets/Group1.png'))
                  //                           ),
                  //                           child: Center(child: Image(image: AssetImage('assets/Group1.png'),height: 30,width: 30,)),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         ],
                  //       );
                  //     }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              // height: 120,
              width: MediaQuery.of(context).size.width,
              color: notifier.containercoloreproper,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Image(
                          image: AssetImage('assets/Rectangle_2.png'),
                          height: 40),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, bottom: 10),
                        child: Text(
                          'Contact Details'.tr,
                          style: TextStyle(
                              color: notifier.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name'.tr,
                                style: TextStyle(
                                    fontSize: 14, color: notifier.textColor),
                                maxLines: 1),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                controller: FullnameController,
                                style: TextStyle(color: notifier.textColor),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.pink)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Color(0xff7D2AFF))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4))),
                                  hintText: 'Enter Your Name'.tr,
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email Id'.tr,
                                style: TextStyle(
                                    fontSize: 14, color: notifier.textColor),
                                maxLines: 1),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                style: TextStyle(color: notifier.textColor),
                                controller: EmailController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.pink)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xff7D2AFF))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    hintText: 'Enter Email id'.tr,
                                    hintStyle: const TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact Details'.tr,
                                style: TextStyle(
                                    fontSize: 14, color: notifier.textColor),
                                maxLines: 1),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                style: TextStyle(color: notifier.textColor),
                                keyboardType: TextInputType.number,
                                controller: mobileController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.pink)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color(0xff7D2AFF))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    hintText: 'Enter Mobile Number'.tr,
                                    hintStyle: const TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),


            const SizedBox(
              height: 15,
            ),


            const SizedBox(
              height: 15,
            ),


          ],
        ),
      ),
    );
  }

  List<String> data = [];
  submitData() {
    // change icon to back arrow and clear existing data

    data = [];

    // retrieve data from each text field widget and add to data list
    for (var widget in listDynamic) {
      data.add(widget.controller.text);
    }

    setState(() {});
    print(data.length);
    print(data);
  }

  List<String> data1 = [];
  submitData1() {
    // change icon to back arrow and clear existing data

    data1 = [];

    // retrieve data from each text field widget and add to data list
    for (var widget in listDynamicage) {
      data1.add(widget.controller1.text);
    }

    setState(() {});
    print(data1.length);
    print(data1);
  }
}

Widget switchcommoncode() {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'GSTIN'.tr,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Business Name'.tr,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Business Address'.tr,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Business Email'.tr,
          ),
        ),
      ],
    ),
  );
}

Widget switchcommoncode1() {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'GSTIN'.tr,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Business Name'.tr,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Business Address'.tr,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Business Email'.tr,
          ),
        ),
      ],
    ),
  );
}

class DynamicWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  DynamicWidget({super.key});
  ColorNotifier notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return SizedBox(
      height: 40,
      child: TextField(
        style: TextStyle(color: notifier.textColor),
        controller: controller,
        // keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            // contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.pink)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Color(0xff7D2AFF))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
            hintText: 'Enter Full Name'.tr,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
      ),
    );
  }
}

class DynamicWidget1 extends StatelessWidget {
  TextEditingController controller1 = TextEditingController();

  DynamicWidget1({super.key});
  ColorNotifier notifier = ColorNotifier();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return SizedBox(
      height: 40,
      child: TextField(
        style: TextStyle(color: notifier.textColor),
        controller: controller1,
        maxLength: 2,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            // contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.pink)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Color(0xff7D2AFF))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
            hintText: 'Age'.tr,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
      ),
    );
  }
}
