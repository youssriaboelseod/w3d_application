import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';

void whatsAppOpen() async {
  const url = "whatsapp://send?phone=966501722732";
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}

shareApp() {
  Share.share(
      "https://play.google.com/store/apps/details?id=com.moadawy.T_Planners");
}

updateAppUrl() async {
  final InAppReview inAppReview = InAppReview.instance;

  inAppReview.openStoreListing(appStoreId: 'com.moadawy.T_Planners');
}

_openPrivacy() async {
  const url = '';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_openInstagram() async {
  const url =
      'https://www.instagram.com/tm_planners/?igshid=jg62k3q9ef3k&fbclid=IwAR1l3Ize9FtiLNNq39ccpzQ9OlIoOdh7zUVqYydWu72Nn-uovclbZCZz6Fc';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_openFacebookUrl() async {
  const url = 'https://www.facebook.com/tm.planners';
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
                        whatsAppOpen();
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
