import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black38,
            blurRadius: 15.0,
          ),
        ],
        borderRadius: BorderRadius.circular(29),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 40,
          ),
          onPressed: press,
          child: Text(
            text,
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
