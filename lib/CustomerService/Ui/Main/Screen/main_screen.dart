import 'package:flutter/material.dart';
import '../../1MainHelper/Colors/colors.dart';
import '../Widgets/body.dart';

class CustomerServiceMainScreen extends StatelessWidget {
  static const routeName = "/customer-service-main-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customerServiceBackgroundMain,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Body(),
    );
  }
}
