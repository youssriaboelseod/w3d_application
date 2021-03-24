import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:html/parser.dart' show parse;
import 'package:google_fonts_arabic/fonts.dart';

import '../../../Models/Product/product_model.dart';

class DescriptionCard extends StatelessWidget {
  final String title;
  final WooProduct productModel;

  const DescriptionCard({Key key, this.title, this.productModel})
      : super(key: key);

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;
    //print(parsedString);
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(productModel.priceHtml);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              title.isEmpty ? "" : title,
              textScaleFactor: 1,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: size.width,
            child: Text(
              productModel.shortDescription.isEmpty
                  ? ""
                  : _parseHtmlString(productModel.shortDescription),
              textScaleFactor: 1,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                color: Colors.grey[700],
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
