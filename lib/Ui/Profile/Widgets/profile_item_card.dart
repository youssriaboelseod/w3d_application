import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class ProfileItemCard extends StatelessWidget {
  final String title;
  final String initialText;
  final IconData prefixIcon;

  final Function function;

  ProfileItemCard({
    Key key,
    this.title,
    this.initialText,
    this.prefixIcon,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Icon(
              prefixIcon,
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              margin: EdgeInsets.only(
                right: 2,
              ),
              child: Text(
                title + " : ",
                textScaleFactor: 1,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              margin: EdgeInsets.only(
                right: 2,
              ),
              width: size.width / 2.5,
              child: Text(
                initialText,
                textScaleFactor: 1,
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Spacer(),
            function == null
                ? Container()
                : IconButton(
                    icon: Icon(
                      Icons.edit,
                    ),
                    onPressed: function,
                  ),
          ],
        ),
      ),
    );
  }
}
