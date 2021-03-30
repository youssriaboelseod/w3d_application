import 'package:flutter/material.dart';
import '../Widgets/body.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = "/signup_scrren";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Body(),
    );
  }
}
