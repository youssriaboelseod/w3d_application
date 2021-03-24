import 'package:flutter/material.dart';

import '../Widgets/body.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf0f0),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "حسابي",
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset("assets/images/logo.png"),
        ],
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
