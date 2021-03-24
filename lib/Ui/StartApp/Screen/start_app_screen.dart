import '../Widgets/body.dart';

import 'package:flutter/material.dart';

class StartAppScreen extends StatelessWidget {
  static const routeName = "/start_screen";
  @override
  Widget build(BuildContext context) {
    final bool state = ModalRoute.of(context).settings.arguments;
    print(state);
    return Scaffold(
      body: Body(
        state: state,
      ),
    );
  }
}
