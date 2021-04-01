import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../Widgets/otp_code_card.dart';

class VerifyCodeScreen extends StatelessWidget {
  static const routeName = "/verify_code_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          children: [
            OtpCodeCard(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      centerTitle: true,
      title: Text(
        "تأكيد رقم الهاتف",
        textScaleFactor: 1,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
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
