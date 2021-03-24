import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:google_fonts_arabic/fonts.dart';

class TitleCard extends StatelessWidget {
  final WooProduct productModel;

  TitleCard({Key key, this.productModel}) : super(key: key);
  String purchaseQuantity = "";
  bool showPurchaseQuantity = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    try {
      purchaseQuantity =
          productModel.priceHtml.split("class=\"items-sold-texts\" >")[1];
      print("1");
      print(purchaseQuantity);
      if (purchaseQuantity.contains("قطع تم شرائها")) {
        purchaseQuantity = purchaseQuantity.split("قطع تم شرائها")[0].trim();
      } else {
        purchaseQuantity = purchaseQuantity.split("قطعة تم شرائها")[0].trim();
      }
    } catch (_) {
      showPurchaseQuantity = false;
    }

    print("2");
    print(purchaseQuantity);
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
              productModel.name ?? "",
              textScaleFactor: 1,
              overflow: TextOverflow.fade,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize: 21.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              (productModel.onSale && productModel.regularPrice.isNotEmpty)
                  ? Text(
                      productModel.regularPrice.toString() + "  ر.س",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      textDirection: TextDirection.rtl,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 18,
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 15,
              ),
              Text(
                productModel.price.isNotEmpty
                    ? productModel.price.toString() + "  ر.س"
                    : "",
                textAlign: TextAlign.center,
                maxLines: 1,
                textDirection: TextDirection.rtl,
                textScaleFactor: 1,
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          !showPurchaseQuantity
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "قطع تم شرائها",
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      textDirection: TextDirection.rtl,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      purchaseQuantity,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.add_chart,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
