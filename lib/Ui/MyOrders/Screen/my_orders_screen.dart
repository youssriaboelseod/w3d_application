import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts_arabic/fonts.dart';
import '../Widgets/body.dart';

// ignore: must_be_immutable
class MyOrdersScreen extends StatelessWidget {
  static const routeName = "/my_orders_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      backgroundColor: Colors.grey[200],
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      // On Android by default its false
      centerTitle: true,
      title: Text(
        "طلباتي",
        textScaleFactor: 1,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      actions: [
        Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
