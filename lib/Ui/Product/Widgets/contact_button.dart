import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:w3d/Ui/1MainHelper/Helpers/my_dynamic_link_service.dart';
import 'package:woocommerce/models/products.dart';
import 'package:html/parser.dart' show parse;

//

class ContactButton extends StatelessWidget {
  final WooProduct product;

  const ContactButton({Key key, @required this.product}) : super(key: key);
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  whatsAppOpen() async {
    String myUrl = "";
    print(product.externalUrl);
    if (product.externalUrl != null && product.externalUrl.isNotEmpty) {
      myUrl = product.externalUrl
          .replaceAll("https://wsend.co/", "whatsapp://send?phone=");
    } else {
      myUrl = _parseHtmlString(product.description);
    }
    final DynamicLinkParameters parameters =
        MyDynamicLinkService().createDynamicLinkFunction(
      product.id.toString(),
    );
    print("Product ID To Share == ");
    print(product.id.toString());
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();

    final Uri shortUrl = shortDynamicLink.shortUrl;
    final productDynamicLink = shortUrl.toString();

    myUrl = myUrl + "&text=$productDynamicLink";
    print(myUrl);
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
