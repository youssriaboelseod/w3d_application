import 'package:flutter/material.dart';
//
import '../Widgets/body.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf0f0),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Body(),
    );
  }
}
