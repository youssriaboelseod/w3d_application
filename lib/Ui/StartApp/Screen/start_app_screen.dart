import 'package:flutter/material.dart';
//
import '../Widgets/body.dart';

class StartAppScreen extends StatelessWidget {
  static const routeName = "/start_screen";

  const StartAppScreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
