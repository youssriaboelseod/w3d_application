import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts_arabic/fonts.dart';
import '../../../Providers/DynamicLinksProvider/dynamic_links_provider.dart';
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

  whatsAppOpen(BuildContext context) async {
    String myUrl = "";

    if (product.externalUrl != null && product.externalUrl.isNotEmpty) {
      myUrl = product.externalUrl
          .replaceAll("https://wsend.co/", "whatsapp://send?phone=");
    } else {
      myUrl = _parseHtmlString(product.description);
    }

    print("Product ID To Share == ");
    print(product.id.toString());

    final productDynamicLink =
        await Provider.of<DynamicLinksProvider>(context, listen: false)
            .createAndGetDynamicLink(
      itemId: product.id.toString(),
      itemName: product.name,
      itemUrl: product.images.length == 0
          ? Uri.parse(
              "https://firebasestorage.googleapis.com/v0/b/w3d-app.appspot.com/o/login.png?alt=media&token=f9a3d494-6502-4065-8b69-a80f716eef6f")
          : Uri.parse(product.images[0].src),
    );

    myUrl = myUrl + "&text=$productDynamicLink";

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
        await whatsAppOpen(context);
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
                "تواصل مع البائع",
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
              SvgPicture.asset(
                "assets/icons/whatsapp_black.svg",
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
