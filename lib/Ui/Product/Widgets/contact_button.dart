import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:woocommerce/models/products.dart';

//

class ContactButton extends StatelessWidget {
  final WooProduct product;

  const ContactButton({Key key, @required this.product}) : super(key: key);

  whatsAppOpen() async {
    //"whatsapp://send?phone=218911299270"
    print(product.externalUrl);

    String myUrl = product.externalUrl
        .replaceAll("https://wsend.co/", "whatsapp://send?phone=");
    myUrl = myUrl + "&text=P: ${product.permalink}";
    if (await canLaunch(myUrl)) {
      await launch(myUrl, forceSafariVC: false);
    } else {
      throw 'Could not launch $myUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await whatsAppOpen();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.blue,
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "للتواصل",
                textScaleFactor: 1,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Icon(
                Icons.call,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
