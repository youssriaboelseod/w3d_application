import '../Widgets/body.dart';

import 'package:flutter/material.dart';

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
