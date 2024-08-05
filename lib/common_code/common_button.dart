// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/light_and_dark.dart';


Widget CommonButton({String? txt1,String? txt2,required Color containcolore,context}){
  return  Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: containcolore,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: RichText(text: TextSpan(
            children: [
              TextSpan(text: txt1,style: const TextStyle(fontSize: 15,)),
              TextSpan(text: txt2,style: const TextStyle(fontSize: 15)),
            ]
        )),
      )
  );
}

Widget CommonButtonWithBorder({String? txt1,String? txt2, Color? containcolore,context}){
  return  Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: containcolore,
      ),
      child: Center(
        child: RichText(text: TextSpan(
            children: [
              TextSpan(text: txt1,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              TextSpan(text: txt2,style: const TextStyle(fontSize: 15,color: Colors.black)),
            ]
        )),
      )
  );
}



Widget CommonTextfiled({ TextEditingController? controller}){
  return  TextField(
    controller: controller,
    decoration:  const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10,),
            Text('+91',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
            Image(image: AssetImage('assets/caret-down.png'),color: Colors.black,),
            SizedBox(width: 10,),
          ],
        ),



      // prefixIcon:  InternationalPhoneNumberInput(
      //   controller: controller,
      //   betweenPadding: 15,
      //   // onInputChanged: (number) {
      //   //   setState(() {
      //   //     ccode  =  number.dial_code;
      //   //   });
      //   // },
      //
      //   countryConfig: CountryConfig(
      //
      //       flagSize: 24,
      //       decoration: BoxDecoration(
      //         border: Border.all(width: 1.5,),
      //       )
      //   ),
      //
      //   phoneConfig: PhoneConfig(
      //     borderWidth: 1.5,
      //   ),
      // ),




        hintText: 'Enter your mobile number',hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
    ),
  );
}

Widget CommonTextfiled10({ TextEditingController? controller,  String? txt,required BuildContext context}){
  notifier = Provider.of<ColorNotifier>(context, listen: false);
  return  TextField(
    controller: controller,
    obscureText: true,
    style: TextStyle(color: notifier.textColor),
    decoration:  InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Color(0xff7D2AFF))),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
      enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
      hintText: txt,hintStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),
    ),
  );
}

Widget CommonTextfiled2({required String txt,TextEditingController? controller,required BuildContext context}){
  notifier = Provider.of<ColorNotifier>(context, listen: false);
  return TextField(
    controller: controller,
    style: TextStyle(color: notifier.textColor),
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.red)),
        enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
        hintText: txt,hintStyle:  const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Color(0xff7D2AFF))),
    ),
  );
}

Widget CommonTextfiled1({required String text}){
  return  TextField(
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: const OutlineInputBorder(),
        prefixIcon: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10,),
            Text('+91',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
            Image(image: AssetImage('assets/caret-down.png'),color: Colors.black,),
            SizedBox(width: 10,),
          ],
        ),
        hintText: text,hintStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
    ),
  );
}


ColorNotifier notifier = ColorNotifier();


Widget CommonTextfiled200({required String txt,TextEditingController? controller,required BuildContext context}){
  notifier = Provider.of<ColorNotifier>(context, listen: false);
  return TextField(
    controller: controller,
    style: TextStyle(color: notifier.textColor),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.red)),
      enabledBorder:  OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
      hintText: txt,hintStyle:  const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color: Color(0xff7D2AFF))),
    ),
  );
}