import 'package:flutter/material.dart';
//
import '../Widgets/otp_code_card.dart';

class VerifyCodeScreen extends StatelessWidget {
  static const routeName = "/verify_code_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff416d6d),
        title: Text(
          "تأكيد رقم الهاتف",
          textScaleFactor: 1,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xffecf0f0),
        child: Column(
          children: [
            OtpCodeCard(),
          ],
        ),
      ),
    );
  }
}
