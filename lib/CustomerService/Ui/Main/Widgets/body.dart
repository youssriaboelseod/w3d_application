import 'package:flutter/material.dart';
import '../../1MainHelper/Colors/colors.dart';
import '../../1MainHelper/FontSize/fonst_size.dart';
import 'buttons.dart';
import '../Functions/register_in_queue.dart';

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
            "Welcome To The Customer Service",
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(
              fontFamily: 'Raphtalia',
              fontSize: getFontSize(size.width) + 6,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          height: size.height * 0.45,
          child: Image.asset("assets/customer_service_images/main.png"),
        ),
      ],
    );
  }
}

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  bool _isLoading = false;
  void callSetState() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "What would you like to do ?",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: getFontSize(size.width),
                  ),
                ),
              ),
              Button(
                backgroundColor: Color(0xFF8795DD),
                function: () {
                  showStartConversationAlert(
                    context: context,
                    message: "Do you want to talk to customer service?",
                    callSetState: callSetState,
                  );
                },
                title: "Start a conversation",
                textColor: Colors.white,
              ),
              Button(
                backgroundColor: Color(0xFF364F8A),
                function: () {},
                title: "View Frequent questions",
                textColor: Colors.white,
              ),
            ],
          );
  }
}
