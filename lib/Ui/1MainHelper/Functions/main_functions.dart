import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

void whatsAppOpen() async {
  const url = "whatsapp://send?phone=218911299270";
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}

void whatsAppOpenNew({String phoneNumber, String message}) async {
  FlutterOpenWhatsapp.sendSingleMessage(
    phoneNumber,
    message,
  );
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
