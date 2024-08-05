import 'package:flutter/material.dart';

class ColorNotifier with ChangeNotifier {

  get background => isDark ? const Color(0xff181A20) : Colors.white;
  get textColor => isDark ? Colors.white : const Color(0xff212121);
  get containercolore => isDark ? const Color(0xff35383F) :  const Color(0xffF5F5F5);


  get backgroundgray => isDark ? const Color(0xff181A20) : const Color(0xffF5F5F5);
  get containercoloreproper => isDark ? const Color(0xff35383F) :  Colors.white;




  //language colore
  get languagecontainercolore => isDark ? const Color(0xff35383F) :  const Color(0xffEEEEEE);
  //fagcontainner colore
  get fagcontainer => isDark ? const Color(0xff35383F) :  const Color(0xffEEEEEE);

  //seatcontainercolore
  get seatcontainere => isDark ? const Color(0xff181A20) :  const Color(0xffD6C1F9).withOpacity(0.3);
  get seattextcolore => isDark ? Colors.white :  const Color(0xff7D2AFF);


  bool _isDark = false;
  bool get isDark => _isDark;

  void isAvailable(bool value) {
    _isDark = value;
    notifyListeners();
  }

}

Color primerycolore = const Color(0xff7D2AFF);

