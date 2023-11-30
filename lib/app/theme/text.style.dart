import 'package:dich_vu_it/app/theme/colors.dart';
import 'package:flutter/material.dart';

class MyTextStyle {
  MyTextStyle._();

  static TextStyle heading1 = const TextStyle(
    fontSize: 30,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleTextfile = const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static TextStyle hintTextFiel = const TextStyle(
    fontSize: 15,
    color: Color(0xff8391A1),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static TextStyle btnTextWhite = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static TextStyle styleUnSelectMenu = const TextStyle(
    fontSize: 10,
    color:Color.fromARGB(255, 153, 193, 254),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle styleSelectMenu = const TextStyle(
    fontSize: 10,
    color: MyColors.blue,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );




  //text style
    static TextStyle title1 = const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );
      static TextStyle content1 = const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );
}
