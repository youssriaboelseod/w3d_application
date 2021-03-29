import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

void showTopSnackBar({BuildContext context, String title, String body}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: Color(0xFF151A25),
    boxShadows: [
      BoxShadow(
          color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    isDismissible: false,
    duration: Duration(seconds: 2),
    icon: Icon(
      Icons.check,
      color: Colors.tealAccent,
    ),
    progressIndicatorBackgroundColor: Colors.blueGrey,
    titleText: Text(
      title,
      textScaleFactor: 1,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: ArabicFonts.Cairo,
        package: 'google_fonts_arabic',
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.white,
      ),
      //fontFamily: "ShadowsIntoLightTwo"
    ),
    messageText: Text(
      body,
      textScaleFactor: 1,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: ArabicFonts.Cairo,
        package: 'google_fonts_arabic',
        fontSize: 18.0,
        color: Colors.white,
      ),
    ),
  )..show(context);
}

void showBottomSnackBar({BuildContext context, String title, String body}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: Color(0xFF151A25),
    boxShadows: [
      BoxShadow(
          color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    isDismissible: false,
    duration: Duration(seconds: 2),
    icon: Icon(
      Icons.check,
      color: Colors.tealAccent,
    ),
    progressIndicatorBackgroundColor: Colors.blueGrey,
    titleText: Text(
      title,
      textScaleFactor: 1,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: ArabicFonts.Cairo,
        package: 'google_fonts_arabic',
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.blueAccent,
      ),
      //fontFamily: "ShadowsIntoLightTwo"
    ),
    messageText: Text(
      body,
      textScaleFactor: 1,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: ArabicFonts.Cairo,
        package: 'google_fonts_arabic',
        fontSize: 18.0,
        color: Colors.cyanAccent,
      ),
    ),
  )..show(context);
}
