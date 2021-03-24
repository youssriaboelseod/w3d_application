import 'package:flutter/material.dart';
import '../Widgets/body.dart';

class AddPhoneNumberScreen extends StatelessWidget {
  static const routeName = "/add_phone_number_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff416d6d),
        title: Text(
          "Add Phone Number",
          textScaleFactor: 1,
        ),
      ),
      body: Container(
        color: Color(0xffecf0f0),
        height: double.infinity,
        child: Body(),
      ),
    );
  }
}
