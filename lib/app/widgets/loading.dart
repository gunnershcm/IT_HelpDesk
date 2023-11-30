import 'package:flutter/material.dart';

import 'will.pop.scope.dart';

void onLoading(context) {
  showDialog(
    barrierColor: const Color.fromARGB(0, 158, 158, 158),
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPS(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              // child: CircularProgressIndicator(
              //   color: Colors.blue,
              // ),
              child: SizedBox(width: 100,child: Image.asset("assets/loading-71.gif")),
            ),
          ],
        ),
      );
    },
  );
}
