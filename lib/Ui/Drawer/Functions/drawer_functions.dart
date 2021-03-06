import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import '../../1MainHelper/Functions/main_functions.dart';

shareAppAndroid() async {
  await Share.share(
      "https://play.google.com/store/apps/details?id=com.moadawy.W3d");
}

shareAppIos() async {
  await Share.share(
      "https://apps.apple.com/us/app/%D8%A7%D9%84%D9%88%D8%A7%D8%B9%D8%AF/id1561982511");
}

updateAppUrl() async {
  final InAppReview inAppReview = InAppReview.instance;

  inAppReview.openStoreListing(appStoreId: 'com.moadawy.W3d');
}

_openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}

_sendEmail() async {
  const url = 'mailto:alw3dx@gmail.com?subject=W3D App User&body=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

double getFontSize(double width) {
  double factor;
  if (320 <= width && width < 330) {
    factor = .042;
  } else if (330 <= width && width < 340) {
    factor = .044;
  } else if (340 <= width && width < 350) {
    factor = .046;
  } else if (350 <= width && width < 360) {
    factor = .048;
  } else if (360 <= width && width < 370) {
    factor = .05;
  } else if (370 <= width) {
    factor = .052;
  } else if (width < 320) {
    factor = .035;
  } else {
    factor = .04;
  }
  return (width * factor);
}

void shareAppDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        shareAppAndroid();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      "Android",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.phone_iphone,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        shareAppIos();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      "iOS",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showContact(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _sendEmail();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      "Email",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/whatsapp1.svg",
                      ),
                      onPressed: () {
                        openWhatAppMain(
                          phoneNumber: "966501722732",
                          message: "?????????? ??????????",
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      "Whats",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showAboutW3d(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                child: RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    _openUrl(
                        "https://050saa.com/%D9%85%D9%86-%D9%86%D8%AD%D9%86/");
                  },
                  child: Text(
                    "???? ??????",
                    textScaleFactor: 1,
                    overflow: TextOverflow.fade,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    _openUrl(
                        "https://050saa.com/%D8%B4%D8%B1%D9%88%D8%B7-%D8%A7%D9%84%D8%A5%D8%B3%D8%AA%D8%AE%D8%AF%D8%A7%D9%85/");
                  },
                  child: Text(
                    "???????? ??????????????????",
                    textScaleFactor: 1,
                    overflow: TextOverflow.fade,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    _openUrl(
                        "https://050saa.com/%D8%B3%D9%8A%D8%A7%D8%B3%D8%A9-%D8%A7%D9%84%D8%AE%D8%B5%D9%88%D8%B5%D9%8A%D8%A9/");
                  },
                  child: Text(
                    "?????????? ????????????????",
                    textScaleFactor: 1,
                    overflow: TextOverflow.fade,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
