import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
          top: 4,
          left: 8,
          right: 8,
          bottom: 4,
        ),
        children: [
          Title(
            title: "حوالة مصرفية مباشرة",
            number: "1",
          ),
          SizedBox(
            height: 8,
          ),
          Title2(
            title1: "صاحب الحساب",
            title2: "سلمان الفرج",
          ),
          SizedBox(
            height: 4,
          ),
          Title2(
            title1: "اسم البنك",
            title2: "مصرف الراجحي",
          ),
          SizedBox(
            height: 4,
          ),
          TitleWithCopy(
            title1: "رقم الحساب",
            title2: "104608016008620",
          ),
          SizedBox(
            height: 4,
          ),
          TitleWithCopy(
            title1: "الأيبان",
            title2: "SA1380000104608016008620",
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
            indent: 50,
            endIndent: 50,
          ),
          Title2(
            title1: "اسم البنك",
            title2: "بنك الرياض",
          ),
          SizedBox(
            height: 4,
          ),
          TitleWithCopy(
            title1: "رقم الحساب",
            title2: "3451404129940",
          ),
          SizedBox(
            height: 4,
          ),
          TitleWithCopy(
            title1: "الأيبان",
            title2: "SA5320000003451404129940",
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Title(
            title: "Stc pay",
            number: "2",
          ),
          SizedBox(
            height: 8,
          ),
          Title2(
            title1: "صاحب الحساب",
            title2: "سلمان الفرج",
          ),
          SizedBox(
            height: 4,
          ),
          TitleWithCopy(
            title1: "رقم الجوال",
            title2: "0501722732",
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Title(
            title: "PayPal",
            number: "3",
          ),
          SizedBox(
            height: 8,
          ),
          Title2(
            title1: "صاحب الحساب",
            title2: "سلمان الفرج",
          ),
          SizedBox(
            height: 4,
          ),
          TitleWithCopy(
            title1: "الرابط",
            title2: "https://www.paypal.com/paypalme/050saa",
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String number;
  final String title;

  const Title({Key key, this.number, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            textScaleFactor: 1,
            overflow: TextOverflow.fade,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

class Title2 extends StatelessWidget {
  final String title1;
  final String title2;

  const Title2({Key key, this.title1, this.title2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 10,
      ),
      child: Row(
        children: [
          Text(
            title1 + " : ",
            textScaleFactor: 1,
            overflow: TextOverflow.fade,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title2,
            textScaleFactor: 1,
            overflow: TextOverflow.fade,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 18,
              color: Colors.black,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

void _copyText(String textInp) {
  Clipboard.setData(
    ClipboardData(
      text: textInp,
    ),
  ).then((result) {
    // show toast or snackbar after successfully save
    Fluttertoast.showToast(
      msg: "تم النسخ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  });
}

void lunchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class TitleWithCopy extends StatelessWidget {
  final String title1;
  final String title2;

  const TitleWithCopy({Key key, this.title1, this.title2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        right: 10,
      ),
      child: Row(
        children: [
          Text(
            title1 + " : ",
            textScaleFactor: 1,
            overflow: TextOverflow.fade,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              if (title2.contains("https")) {
                lunchUrl(title2);
              } else {
                _copyText(title2);
              }
            },
            child: Container(
              width: size.width / 1.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title2,
                  textAlign: TextAlign.start,
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    decoration: title2.contains("https")
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 18,
                    color:
                        title2.contains("https") ? Colors.blue : Colors.black,
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
