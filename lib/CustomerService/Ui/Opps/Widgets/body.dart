import 'package:flutter/material.dart';
import '../../1MainHelper/Colors/colors.dart';
import '../../1MainHelper/FontSize/fonst_size.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: customerServiceBackgroundMain,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Top(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 10,
          ),
          child: Text(
            "Opps..",
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(
              fontFamily: 'Raphtalia',
              fontSize: getFontSize(size.width) + 12,
              color: Color(0xFF726F6C),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          height: size.height * 0.45,
          child: Image.asset("assets/customer_service_images/opps.png"),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            left: 8,
            right: 8,
          ),
          child: Text(
            "We are currently unavailable to take your request\n\nPlease contact us during the business hours\n\nBetween 8 Am 10 Pm",
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(
              fontSize: getFontSize(size.width),
              color: Color(0xFF545454),
            ),
          ),
        ),
      ],
    );
  }
}
