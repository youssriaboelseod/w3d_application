import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class RatingStars extends StatelessWidget {
  final int number;

  const RatingStars({Key key, this.number}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            number.toString(),
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "مراجعات",
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 17,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
