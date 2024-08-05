// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';


import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../API_MODEL/home_data_api_model.dart';
import '../API_MODEL/search_get_api_model.dart';

import 'package:http/http.dart' as http;

import '../Sub_Screen/booking_details_screen.dart';
import '../Sub_Screen/search_bus_screen.dart';
import '../config/config.dart';
import '../config/light_and_dark.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

String from = "";
String To = "";
ScrollController controller = ScrollController();

TextEditingController controllerfrom = TextEditingController();
TextEditingController controllerto = TextEditingController();

int currentIndex = 0;
int selectcontain = 0;
int currentIndex1 = -1;

bool updown = false;

final _suggestionTextFiledControoler = TextEditingController();
final _suggestionTextFiledControoler1 = TextEditingController();

// List SuggestionList = [];
// List SuggestionList1 = [
//   'surat',
//   'india',
//   'gujarate',
//   'pakisatan',
//   'kamrej',
//   'simada',
// ];


String bordingId= "";
String dropId= "";
bool isloading = true;



  @override
    void initState() {
      // TODO: implement initState
      getlocledata();
      super.initState();
    }

  //  GET API CALLING
   FromtoModel? from12;

  Future SearchGet() async {
    var response1 = await http.get(Uri.parse('${config().baseUrl}/api/citylist.php'),);
    if (response1.statusCode == 200) {
      var jsonData = json.decode(response1.body);
      print(jsonData["citylist"]);
      setState(() {
      from12 = fromtoModelFromJson(response1.body);
      });
    }
  }

  //Share preferance
   var userData;
   var searchbus;

 getlocledata() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    userData  = jsonDecode(prefs.getString("loginData")!);
    searchbus = jsonDecode(prefs.getString('currency')!);
    SearchGet();
    Home_Data_Api(userData['id']);

    // Book_Ticket(widget.uid, widget.bus_id, widget.pick_id, widget.dropId, widget.trip_date,"${response.paymentId}");
    print('+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${userData["id"]}');
    // print('+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${userData["id"]}');
  });
}

// Home_Data_Api Api Calling

 Homedata? data1;

  Future Home_Data_Api(String uid) async {

    Map body = {
      'uid' : uid,
    };

    print("+++ $body");

    try{
      var response = await http.post(Uri.parse('${config().baseUrl}/api/home_data.php'), body: jsonEncode(body),headers: {
        'Content-Type': 'application/json',
      });

      if(response.statusCode == 200){
      print(response.body);

        setState(() {
          data1 = homedataFromJson(response.body);
          isloading = false;

        });

      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> _refresh()async {
    Future.delayed(const Duration(seconds: 10),() {
      Home_Data_Api(userData['id']);
    },);
  }

  ColorNotifier notifier = ColorNotifier();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      // backgroundColor: const Color(0xffefefef),
      // backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(image: AssetImage('assets/logo.png'),height: 60,width: 60),
            const SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('zigzagbus'.tr,style: const TextStyle(color: Color(0xff7B2BFF),fontSize: 20,fontFamily: 'SofiaProBold'),),
            ),
          ],
        ),
      ),
      backgroundColor: notifier.background,
      body: isloading ? const Center(child: CircularProgressIndicator(color: Color(0xff7D2AFF)),) : RefreshIndicator(
        color: const Color(0xff7D2AFF),
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child:  Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [


                      // const Text('Bus tickets',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),


                      Stack(
                        children: [
                          Column(
                            children: [
                              textfildefrom(),
                              const SizedBox(height: 10,),
                              textfildeto(),
                            ],
                          ),
                          Positioned.directional(
                            textDirection:Directionality.of(context),
                            // right: 20,
                            end: 20,
                            top: 30,
                            child: InkWell(
                              onTap: () {
                                setState((){
                                  fun();
                                },
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: notifier.background,
                                    border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                    borderRadius: BorderRadius.circular(10),
                                    // image: DecorationImage(image: AssetImage(''))
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image(image: AssetImage('assets/arrow-down-arrow-up.png'),height: 25,width: 25,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 15,),

                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.grey.withOpacity(0.4)),
                          //   borderRadius:  BorderRadius.all(Radius.circular(15)),
                          // ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: () {
                                  selectDateAndTime(context);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     const SizedBox(height: 7,),
                                     Text('Date'.tr,style: TextStyle(color: notifier.textColor),),
                                    // Text('Thu,31 Aug',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                                    // const SizedBox(height: 2,),
                                    Text("${selectedDateAndTime.day}/${selectedDateAndTime.month}/${selectedDateAndTime.year}",style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: notifier.textColor)),
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    selectDateAndTime(context);
                                  },
                                  child:  const Padding(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: Image(image: AssetImage('assets/calendar-empty-alt.png'),height: 25,width: 25,),
                                  )),

                              const Spacer(),

                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {

                                      setState(() {
                                        selectcontain = 0;
                                        selectedDateAndTime = DateTime.now();
                                      });

                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      margin: const EdgeInsets.all(5),
                                      // padding: const EdgeInsets.all(10),
                                      // width: index == 0 ?  70 : index == 1 ? 100 : 80,
                                      decoration: BoxDecoration(
                                        color: selectcontain == 0 ? const Color(0xff7D2AFF) : const Color(0xffD6C1F9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child:  Center(child: Text('Today'.tr,style: const TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final now = DateTime.now();

                                      setState(() {
                                        selectcontain = 1;
                                        selectedDateAndTime =DateTime(now.year, now.month, now.day + 1);
                                      });

                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      margin:  const EdgeInsets.all(5),
                                      // padding: const EdgeInsets.all(10),
                                      // width: index == 0 ?  70 : index == 1 ? 100 : 80,
                                      decoration: BoxDecoration(
                                        color: selectcontain == 1 ? const Color(0xff7D2AFF) : const Color(0xffD6C1F9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child:  Center(child: Text('Tomorrow'.tr,style: const TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )
                      ),
                      const SizedBox(height: 10,),

                      InkWell(
                        onTap: () {
                          DateTime now = DateTime.now();
                         String nowDate = now.toString().split(" ").first;
                         String dynamiDate = selectedDateAndTime.toString().split(" ").first;
                         print(nowDate);
                         print(dynamiDate);
                         print(nowDate.compareTo(dynamiDate));

                         bool isnot = false;
                         bool isnot1 = false;
                         for(int a = 0;a<from12!.citylist.length;a++){

                           if(from12!.citylist[a].title.compareTo(_suggestionTextFiledControoler.text) == 0 ){
                             setState(() {
                             isnot = true;
                             });
                           }else{
                           }
                           if(from12!.citylist[a].title.compareTo(_suggestionTextFiledControoler1.text) == 0 ){
                             setState(() {
                               isnot1 = true;
                             });
                           }else{

                           }
                         }
                          if(isnot && isnot1){
                            if(nowDate.compareTo(dynamiDate) == -1 || nowDate.compareTo(dynamiDate) == 0){
                              if(_suggestionTextFiledControoler.text.isNotEmpty && _suggestionTextFiledControoler1.text.isNotEmpty) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      Search_Bus_Screen(
                                          from: _suggestionTextFiledControoler.text,
                                          to: _suggestionTextFiledControoler1.text,
                                          boarding_id: bordingId,
                                          drop_id: dropId,
                                          trip_date: selectedDateAndTime
                                              .toString()
                                              .split(" ")
                                              .first),));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content:  Text('Plese Enter Input'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                                );
                              }
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content:  Text('Service Not Provide At This Date'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                              );
                            }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content:  Text('not valide'.tr),behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color(0xff7D2AFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  Center(child: Text('Search Buses'.tr,style: const TextStyle(color: Colors.white,fontSize: 16),)),
                        ),
                      ),

                      const SizedBox(height: 20,),

                       data1!.tickethistory.isEmpty ? const SizedBox(): Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recent Booking'.tr,style: TextStyle(color: notifier.textColor,fontWeight: FontWeight.bold,fontSize: 20),),
                          const SizedBox(height: 15,),
                          SizedBox(
                            height: 150,
                            // width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 0);
                                },
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: data1!.tickethistory.length,
                                itemBuilder: (BuildContext context, int index) {

                                  // var date1 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busPicktime));
                                  // var date2 = DateFormat("HH:mm").parse(convertTimeTo12HourFormat(data.busData[index].busDroptime));

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Booking_Details(ticket_id: data1!.tickethistory[index].ticketId,isDownload: true),));
                                    },
                                    child: Container(
                                      // height: 200,
                                      width: MediaQuery.of(context).size.width*0.8,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        // color: const Color(0xffEEEEEE),
                                        color: notifier.containercolore,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius: BorderRadius.circular(65),
                                                        image: DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.tickethistory[index].busImg}'),fit: BoxFit.fill))
                                                ),
                                                const SizedBox(width: 10,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('${data1?.tickethistory[index].busName}',style:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: notifier.textColor)),
                                                    const SizedBox(height: 5,),
                                                    Row(
                                                      children: [
                                                        if(data1?.tickethistory[index].isAc == '1')  Text('AC Seater'.tr,style: TextStyle(fontSize: 12,color: notifier.textColor)),
                                                        // if(data.busData[index].isSleeper == '1') const Text('/ Sleeper  '),
                                                        // Text('${data.busData[index].totlSeat} Seat',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                    // const Text('Economy'),
                                                  ],
                                                ),
                                                const Spacer(),
                                                // const Text('Available',style: TextStyle(color: Colors.green,fontSize: 13),),
                                                const SizedBox(width: 4,),
                                                Text('$searchbus${data1?.tickethistory[index].ticketPrice}',style: const TextStyle(color: Color(0xff7D2AFF),fontSize: 15,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(data1!.tickethistory[index].boardingCity,style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: notifier.textColor),overflow: TextOverflow.ellipsis,maxLines: 1),
                                                        const SizedBox(height: 8,),
                                                        Text(convertTimeTo12HourFormat(data1!.tickethistory[index].busPicktime),style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xff7D2AFF)),overflow: TextOverflow.ellipsis,maxLines: 1),
                                                        // const SizedBox(height: 8,),
                                                        // Text(_selectedDate.toString().split(" ").first,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                        // const SizedBox(height: 8,),
                                                        // Text('Seat : ${data.busData[index].totlSeat}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // const Spacer(),
                                                const SizedBox(width: 5,),
                                                Column(
                                                  children: [
                                                    const Image(image: AssetImage('assets/Auto Layout Horizontal.png'),height: 50,width: 100,color: Color(0xff7D2AFF)),
                                                    Text('${data1?.tickethistory[index].differencePickDrop}',style: TextStyle(fontSize: 12,color: notifier.textColor)),
                                                  ],
                                                ),
                                                // const Spacer(),
                                                const SizedBox(width: 5,),
                                                Flexible(
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('${data1?.tickethistory[index].dropCity}',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: notifier.textColor),overflow: TextOverflow.ellipsis,maxLines: 1),
                                                        const SizedBox(height: 8,),
                                                        Text(convertTimeTo12HourFormat(data1!.tickethistory[index].busDroptime),style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xff7D2AFF)),overflow: TextOverflow.ellipsis,maxLines: 1),
                                                        // const SizedBox(height: 8,),
                                                        // Text('${_selectedDate.toString().split(" ").first}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                        // const SizedBox(height: 8,),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                       const SizedBox(height: 15,),

                       Text('Special Offer'.tr,style: TextStyle(color: notifier.textColor,fontWeight: FontWeight.bold,fontSize: 20),),
                       const SizedBox(height: 15,),

                       CarouselSlider(
                          items: [
                            for(int a =0; a< data1!.banner.length; a++) Column(
                              children: [
                                // Lottie.asset(lottie12[a],height: 200),
                                Container(
                                    height: 130,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(image: NetworkImage('${config().baseUrl}/${data1?.banner[a].img}'),fit: BoxFit.fitWidth))
                                ),

                              ],
                            ),
                          ],
                          options: CarouselOptions(
                            height: 150,
                            // aspectRatio: 16/9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0,
                            scrollDirection: Axis.horizontal,
                          )
                      ),

                       const SizedBox(height: 15,),


                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      )
    );
  }



var selectedDateAndTime = DateTime.now();

Future<void> selectDateAndTime(context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDateAndTime,
    firstDate: DateTime(2010),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff7D2AFF),
            onPrimary: Colors.white,
            onSurface: Color(0xff7D2AFF),
          ),
          textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              // primary: Colors.black,
              foregroundColor: Colors.black,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  print(pickedDate);
  if (pickedDate != null && pickedDate != selectedDateAndTime) {
    setState(() {
      selectedDateAndTime = pickedDate;
    });
  }
 }



  Widget textfildefrom(){
   return SizedBox(
     height: 45,
     child: Center(
       child: AutoCompleteTextField(
         controller: _suggestionTextFiledControoler,
         clearOnSubmit: false,
         suggestions: from12!.citylist,
         style:   TextStyle(color: notifier.textColor,fontSize: 16.0),
         decoration:  InputDecoration(
           contentPadding: const EdgeInsets.only(top: 30),
           prefixIcon: const Padding(
             padding: EdgeInsets.all(9),
             child: Image(image: AssetImage('assets/bus.png')),
           ),
           // prefix: Image(image: AssetImage('assets/bus.png')),
           hintText: 'From'.tr,hintStyle: TextStyle(color: notifier.textColor),
           // fillColor: Colors.red,
           focusedBorder: const OutlineInputBorder(
               borderSide: BorderSide(color: Color(0xff7D2AFF)),
               borderRadius: BorderRadius.all(Radius.circular(10)),
             ),
           border: const OutlineInputBorder(
               borderSide: BorderSide(color: Colors.red),
             borderRadius: BorderRadius.all(Radius.circular(10)),
           ),
           enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
             borderRadius: const BorderRadius.all(Radius.circular(10)),
           )
         ),
         itemFilter: (item,query){
           print(query);
           return item.title.toLowerCase().contains(query.toLowerCase());
         },
         itemSorter: (a,b){
           print("$a $b");
           return a.title.compareTo(b.title);
         },
         cursorColor: notifier.textColor,
         itemSubmitted: (item){

           setState(() {
             bordingId = item.id;
           });

           _suggestionTextFiledControoler.text = item.title;

         },
         itemBuilder: (context , item){
           return Container(
             color: notifier.containercolore,
             padding: const EdgeInsets.all(20.0),
             child: Row(
               children: [
                 Text(
                   item.title,
                   style:  TextStyle(color: notifier.textColor),
                 ),
               ],
             ),
           );
         }, key: key1,
       ),
     ),
   );
  }
  // static const List<String> _kOptions = <String>[
  //   'aardvark',
  //   'bobcat',
  //   'chameleon',
  // ];
  //
  //
  // Widget textfildefrom(String item){
  //  return Container(
  //    height: 45,
  //    child: Center(
  //      child: Autocomplete<String>(
  //        optionsBuilder: (TextEditingValue textEditingValue) {
  //          if (textEditingValue.text == '') {
  //            return const Iterable<String>.empty();
  //          }
  //          return _kOptions.where((String option) {
  //            return option.contains(textEditingValue.text.toLowerCase());
  //          });
  //        },
  //        onSelected: (String selection) {
  //          debugPrint('You just selected $selection');
  //        },
  //      ),
  //    ),
  //  );
  // }

  GlobalKey<AutoCompleteTextFieldState<dynamic>> key = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<dynamic>> key1 = GlobalKey();

  Widget textfildeto(){
    return SizedBox(
      height: 45,
      child: Center(
        child: AutoCompleteTextField(
          controller: _suggestionTextFiledControoler1,
          clearOnSubmit: false,
          suggestions: from12!.citylist,
          style:  TextStyle(color: notifier.textColor,fontSize: 16.0),
          decoration:  InputDecoration(
            contentPadding: const EdgeInsets.only(top: 10),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(9),
              child: Image(image: AssetImage('assets/bus.png'),height: 25,width: 25,),
            ),
            hintText: 'to'.tr,hintStyle: TextStyle(color: notifier.textColor),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff7D2AFF)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              )
          ),
          cursorColor: notifier.textColor,
          itemFilter: (item,query){
            print("---q---$query");
            print("--item --${item.title}");
            // return item.title.toLowerCase().compareTo(query.toLowerCase());
            // return item.title.toLowerCase().startsWith(query.compareTo(from));
            return item.title.toLowerCase().contains(query.toLowerCase());
          },
          itemSorter: (a,b){
            print("++++++++++++++++++++++++------------526844565$a $b");
            print("++++++++++++++++++++++++------------526844565");
            return a.title.compareTo(b.title);
          },
          itemSubmitted: (item){

            setState(() {
             dropId = item.id;
            });

            _suggestionTextFiledControoler1.text = item.title;

          },
          itemBuilder: (context , item){
            return Container(
              color: notifier.containercolore,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    item.title,
                    style:  TextStyle(color: notifier.textColor),
                  ),
                ],
              ),
            );
          },key: key,
        ),
      ),
    );
  }

  void fun(){
    setState(() {

      var temp2 = bordingId;
      bordingId = dropId;
      dropId = temp2;

      var temp = _suggestionTextFiledControoler.text;
      _suggestionTextFiledControoler.text = _suggestionTextFiledControoler1.text;
      _suggestionTextFiledControoler1.text = temp;

    });
  }

}



// 9727979960


// "bus_id" : 1,
// "uid": "34",

//user_id










// name: zigzag
// description: A new Flutter project.
// # The following line prevents the package from being accidentally published to
// # pub.dev using `flutter pub publish`. This is preferred for private packages.
// publish_to: 'none' # Remove this line if you wish to publish to pub.dev
//
// # The following defines the version and build number for your application.
// # A version number is three numbers separated by dots, like 1.2.43
// # followed by an optional build number separated by a +.
// # Both the version and the builder number may be overridden in flutter
// # build by specifying --build-name and --build-number, respectively.
// # In Android, build-name is used as versionName while build-number used as versionCode.
// # Read more about Android versioning at https://developer.android.com/studio/publish/versioning
// # In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
// # Read more about iOS versioning at
// # https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
// # In Windows, build-name is used as the major, minor, and patch parts
// # of the product and file versions while build-number is used as the build suffix.
// version: 1.0.0+1
//
// environment:
// sdk: '>=3.1.0 <4.0.0'
//
// # Dependencies specify other packages that your package needs in order to work.
// # To automatically upgrade your package dependencies to the latest versions
// # consider running `flutter pub upgrade --major-versions`. Alternatively,
// # dependencies can be manually updated by changing the version numbers below to
// # the latest version available on pub.dev. To see which dependencies have newer
// # versions available, run `flutter pub outdated`.
// dependencies:
// flutter:
// sdk: flutter
//
//
// # The following adds the Cupertino Icons font to your application.
// # Use with the CupertinoIcons class for iOS style icons.
// cupertino_icons: ^1.0.2
// get: ^4.6.6
// screenshot: ^2.1.0
// image_gallery_saver: ^2.0.3
// permission_handler: ^10.3.0
// flutter_lints: ^3.0.0
// smooth_page_indicator: ^1.1.0
// otp_text_field: ^1.1.3
// syncfusion_flutter_datepicker: ^23.1.43
// table_calendar: ^3.0.9
// firebase_core : any
// firebase_auth: any
// intl_phone_field: ^3.2.0
// intl_phone_number_field: ^0.1.8
// autocomplete_textfield: ^2.0.1
// shared_preferences: ^2.2.2
// carousel_slider: ^4.2.1
// lottie: ^2.7.0
// fluttertoast: ^8.2.2
// razorpay_flutter: ^1.3.5
// share_plus: ^7.2.1
// flutter_widget_from_html_core: ^0.14.6
// flutter_share: ^2.0.0
// path_provider: ^2.1.1
// flutter_rating_bar: ^4.0.1
// pdf: ^3.10.4
// printing: ^5.11.0
// flutter_pdfview: ^1.3.2
// flutter_spinkit: ^5.2.0
// webview_flutter: ^3.0.4
// http_auth: ^1.0.4
// flutter_paystack: any
//
// #  pdf: ^3.10.4
// #  pdf_viewer_plugin: ^2.0.1
// #  printing: ^5.11.0
//
// dev_dependencies:
// flutter_test:
// sdk: flutter
//
// # The "flutter_lints" package below contains a set of recommended lints to
// # encourage good coding practices. The lint set provided by the package is
// # activated in the `analysis_options.yaml` file located at the root of your
// # package. See that file for information about deactivating specific lint
// # rules and activating additional ones.
//
// # For information on the generic Dart part of this file, see the
// # following page: https://dart.dev/tools/pub/pubspec
//
// # The following section is specific to Flutter packages.
// flutter:
//
// # The following line ensures that the Material Icons font is
// # included with your application, so that you can use the icons in
// # the material Icons class.
// uses-material-design: true
//
// # To add assets to your application, add an assets section, like this:
// # assets:
// #   - images/a_dot_burr.jpeg
// #   - images/a_dot_ham.jpeg
// assets:
// - assets/
// - assets/lottie/
// fonts:
// - family: SofiaProLight
// fonts:
// - asset: assets/All_Fonts/SofiaProLight.ttf
// - family: SofiaProBold
// fonts:
// - asset: assets/All_Fonts/SofiaProBold.ttf
// # An image asset can refer to one or more resolution-specific "variants", see
// # https://flutter.dev/assets-and-images/#resolution-aware
//
// # For details regarding adding assets from package dependencies, see
// # https://flutter.dev/assets-and-images/#from-packages
//
// # To add custom fonts to your application, add a fonts section here,
// # in this "flutter" section. Each entry in this list should have a
// # "family" key with the font family name, and a "fonts" key with a
// # list giving the asset and other descriptors for the font. For
// # example:
// # fonts:
// #   - family: Schyler
// #     fonts:
// #       - asset: fonts/Schyler-Regular.ttf
// #       - asset: fonts/Schyler-Italic.ttf
// #         style: italic
// #   - family: Trajan Pro
// #     fonts:
// #       - asset: fonts/TrajanPro.ttf
// #       - asset: fonts/TrajanPro_Bold.ttf
// #         weight: 700
// #
// # For details regarding fonts from package dependencies,
// # see https://flutter.dev/custom-fonts/#from-packages

