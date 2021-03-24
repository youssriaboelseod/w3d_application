import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

void showAlertNoAction({BuildContext context, String message}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textScaleFactor: 1,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "حسنا",
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> showAlertYesOrNo({
  BuildContext context,
  String title,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      content: Text(
        title,
        textScaleFactor: 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
          fontSize: 20,
        ),
      ),
      title: Text(
        "تحذير",
        textScaleFactor: 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context, "no"),
          child: Text(
            "لا",
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 18,
            ),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context, "yes"),
          child: Text(
            "نعم",
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
  );
}
