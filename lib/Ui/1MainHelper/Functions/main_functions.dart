import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

void openWhatAppMain({String phoneNumber, String message}) async {
  if (Platform.isAndroid) {
    openWhatsAppUsingPlugin(
      phoneNumber: phoneNumber,
      message: message,
    );
  } else if (Platform.isIOS) {
    openWhatsAppUsingUrl(
      phoneNumber: phoneNumber,
      message: message,
    );
  }
}

void openWhatsAppUsingPlugin({String phoneNumber, String message}) async {
  try {
    await FlutterOpenWhatsapp.sendSingleMessage(
      phoneNumber,
      message,
    );
  } catch (_) {
    // Nothing to do
  }
}

void openWhatsAppUsingUrl({String phoneNumber, String message}) async {
  String url0 = "whatsapp://send?phone=" + phoneNumber + "&text=" + message;
  //
  String url1 = "https://wa.me/" + phoneNumber + "?text=" + message;
  //

  String url2 = "https://api.whatsapp.com/send?phone=" +
      phoneNumber +
      "=" +
      Uri.parse(message).toString();
  //
  String url3 = "https://wsend.co/" + phoneNumber + "&text=" + message;

  //"whatsapp://send?phone=213793187939&text=$message";
  // "https://wa.me/201146448864?text=Hello"),
  // https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}";
  try {
    await launch(url0, forceSafariVC: false);
  } catch (_) {
    try {
      await launch(url1, forceSafariVC: false);
    } catch (_) {
      try {
        await launch(url2, forceSafariVC: false);
      } catch (_) {
        try {
          await launch(url3, forceSafariVC: false);
        } catch (_) {
          // That's it ,
        }
      }
    }
  }
}

void openUrl({@required String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

double getRatio(double width) {
  double factor;
  if (320 <= width && width < 360) {
    factor = .6;
  } else if (360 <= width && width < 399) {
    factor = .65;
  } else if (399 <= width && width < 440) {
    factor = .74;
  } else if (440 <= width && width < 500) {
    factor = .79;
  } else if (500 <= width && width < 560) {
    factor = .84;
  } else if (560 <= width && width < 620) {
    factor = .89;
  } else if (620 <= width) {
    factor = .93;
  } else if (width < 320) {
    factor = .6;
  } else {
    factor = .7;
  }
  return factor;
}
