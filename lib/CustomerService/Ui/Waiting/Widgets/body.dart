import 'package:flutter/material.dart';
import 'waitng_in_queue_block.dart';
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
                    Bottom(),
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
            vertical: 8,
          ),
          child: Text(
            "Please wait a few minutes ...",
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(
              fontFamily: 'Raphtalia',
              fontSize: getFontSize(size.width) + 6,
              color: Color(0xFF726F6C),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          height: size.height * 0.27,
          child: Image.asset("assets/customer_service_images/waiting_top.png"),
        ),
        Container(
          margin: EdgeInsets.all(8),
          height: size.height * 0.27,
          child:
              Image.asset("assets/customer_service_images/waiting_bottom.png"),
        ),
      ],
    );
  }
}

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaitingInQueueBlock();
  }
}
