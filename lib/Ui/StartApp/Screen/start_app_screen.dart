import 'package:flutter/material.dart';
//
import '../Widgets/body.dart';
import '../../../push_nofitications.dart';

class StartAppScreen extends StatefulWidget {
  static const routeName = "/start_screen";

  const StartAppScreen({
    Key key,
  }) : super(key: key);

  @override
  _StartAppScreenState createState() => _StartAppScreenState();
}

class _StartAppScreenState extends State<StartAppScreen> {
  @override
  void initState() {
    PushNotificationsManager().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
