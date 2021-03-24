import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

void whatsAppOpen({String productId}) async {
  //213793187939
  String url = "whatsapp://send?phone=213793187939&text=P: $productId";
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
  const url =
      'mailto:info.mt.adawy.group@gmail.com?subject=TM Planners App User&body=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_sendMessenger() async {
  const url = 'http://m.me/tm.planners';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_sendViber() async {
  const url = "viber://add?number=213793187939";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

double getFontSize(double width) {
  print(width);
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

void showOrderContact({BuildContext context, String productId}) {
  print(productId);
  TextEditingController _controller = TextEditingController(text: productId);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(0),
        backgroundColor: Color(0xFF151A25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        content: Container(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Code : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: productId,
                          ),
                        ).then((result) {
                          Fluttertoast.showToast(
                            msg: "Code is copied",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color(0xFF416D6D),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        });
                      },
                      child: Container(
                        width: 165,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Text(
                              productId,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Order via : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/messenger_black.svg",
                            ),
                            onPressed: () {
                              _sendMessenger();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Messenger",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Order via : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/whatsapp_black.svg",
                            ),
                            onPressed: () {
                              whatsAppOpen(
                                productId: productId,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Whatsapp",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Order via : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/instagram.svg",
                            ),
                            onPressed: () {
                              _openInstagram();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Instagram",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Order via : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/viber.svg",
                            ),
                            onPressed: () {
                              _sendViber();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Viber",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
