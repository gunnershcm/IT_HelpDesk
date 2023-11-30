// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<bool> showNoti(context) async {
  var response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 343,
            height: 240,
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/noti.svg"),
                Text(
                  "Are you sure?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 48,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 196, 196, 196),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "No",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                    )),
                    Expanded(
                        child: Container(
                      height: 48,
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff1D4A96),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Center(
                              child: Text(
                            "Yes",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ))),
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      });
  if (response == true) {
    return true;
  } else {
    return false;
  }
}
