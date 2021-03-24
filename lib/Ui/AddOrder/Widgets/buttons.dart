import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

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
        minWidth: 150,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: backgroundColor,
        icon: Icon(
          iconData,
          color: Colors.white,
        ),
        label: Text(
          title,
          textScaleFactor: 1,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
    );
  }
}
