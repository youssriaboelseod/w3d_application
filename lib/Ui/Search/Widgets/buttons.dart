import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function function;
  final IconData iconData;
  final backgroundColor;
  final textColor;

  const Button({
    Key key,
    this.title,
    this.function,
    this.backgroundColor,
    this.textColor,
    this.iconData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 5,
      ),
      child: FlatButton.icon(
        minWidth: 110,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: backgroundColor,
        icon: Icon(
          iconData,
          color: Colors.black,
        ),
        label: Text(
          title,
          textScaleFactor: 1,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
    );
  }
}
