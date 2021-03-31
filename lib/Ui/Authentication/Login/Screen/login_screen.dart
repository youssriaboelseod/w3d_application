import 'package:flutter/material.dart';
//
import '../Widgets/body.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login_scrren";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Body(),
    );
  }
}
