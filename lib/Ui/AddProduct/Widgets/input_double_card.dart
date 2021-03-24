import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts_arabic/fonts.dart';

class InputDoubleCard extends StatelessWidget {
  final String type;
  final String hintText;
  final ValueChanged<String> onChangeFirst;

  const InputDoubleCard({
    Key key,
    this.type,
    this.hintText,
    this.onChangeFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: Text(
              "ر.س ",
              textAlign: TextAlign.right,
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            width: 120,
            child: Card(
              color: Colors.blueGrey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: onChangeFirst,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.multiline,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  //hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: Text(
              type + " : ",
              textAlign: TextAlign.right,
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
