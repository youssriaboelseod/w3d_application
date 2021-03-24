import 'package:flutter/material.dart';
import '../../1MainHelper/Colors/colors.dart';

class LeftSideMessage extends StatelessWidget {
  final String message;
  LeftSideMessage(this.message);

  @override
  Widget build(BuildContext context) {
    double font = 18;
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        top: 5,
      ),
      child: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                  bottom: 8,
                  left: 26,
                ),
                decoration: BoxDecoration(
                  color: containerLeftBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                width: 200,
                child: Text(
                  message,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: font,
                    color: containerLeftText,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: CircleAvatar(
              backgroundColor: circleLeftBackground,
              child: Text(
                "E",
                textScaleFactor: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: circleLeftText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RightSideMessage extends StatelessWidget {
  final String message;
  RightSideMessage(this.message);

  @override
  Widget build(BuildContext context) {
    double font = 18;
    return Padding(
      padding: const EdgeInsets.only(
        right: 5,
        top: 5,
      ),
      child: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                  bottom: 8,
                  right: 26,
                ),
                decoration: BoxDecoration(
                  color: containerRightBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                width: 200,
                child: Text(
                  message,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: font,
                    color: containerRightText,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: circleRightBackground,
              child: Text(
                "U",
                textScaleFactor: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: circleRightText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
