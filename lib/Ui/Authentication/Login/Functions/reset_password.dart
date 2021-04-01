import 'package:url_launcher/url_launcher.dart';

//

void contactToResetPassword(String email) async {
  final String url = "whatsapp://send?phone=966501722732&text=$email";
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}
