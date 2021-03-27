import '../Widgets/body.dart';

import 'package:flutter/material.dart';

class StartAppScreen extends StatelessWidget {
  final bool state;
  static const routeName = "/start_screen";

  const StartAppScreen({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        state: state,
      ),
    );
  }
}
