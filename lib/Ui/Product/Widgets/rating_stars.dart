import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/ReviewsProvider/reviews_provider.dart';

// ignore: must_be_immutable
class RatingStars extends StatelessWidget {
  RatingStars({Key key}) : super(key: key);
  int number = 0;
  int averageRate = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Consumer<ReviewsProvider>(builder: (context, value, child) {
      int length = value.reviews.length;
      if (length != 0) {
        number = length;
        int totalRates = 0;
        value.reviews.forEach((element) {
          if (element.rating != null) {
            totalRates += element.rating;
          }
        });
        averageRate = (totalRates / number).round();
      }
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            ...List.generate(
              averageRate,
              (index) => Icon(
                Icons.star,
                color: Colors.yellow,
                size: (size.width < 340) ? 20 : 25,
              ),
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
    });
  }
}
