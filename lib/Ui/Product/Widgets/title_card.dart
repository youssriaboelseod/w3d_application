import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../Functions/add_review.dart';
import 'rating_stars.dart';
import '../../Seller/Screen/seller_products_screen.dart';

// ignore: must_be_immutable
class TitleCard extends StatelessWidget {
  final Map<String, dynamic> productMap;
  final String newPrice;
  final String newRegularPrice;

  TitleCard({
    Key key,
    this.productMap,
    this.newPrice,
    this.newRegularPrice,
  }) : super(key: key);
  String purchaseQuantity = "";
  bool showPurchaseQuantity = true;
  String vendorName = "";
  String vendorId = "";

  @override
  Widget build(BuildContext context) {
    vendorId = productMap["vendorId"].toString();
    vendorName = productMap["vendorName"];

    try {
      purchaseQuantity = productMap["value"]
          .priceHtml
          .split("class=\"items-sold-texts\" >")[1];

      if (purchaseQuantity.contains("قطع تم شرائها")) {
        purchaseQuantity = purchaseQuantity.split("قطع تم شرائها")[0].trim();
      } else {
        purchaseQuantity = purchaseQuantity.split("قطعة تم شرائها")[0].trim();
      }
    } catch (_) {
      showPurchaseQuantity = false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productMap["value"].name ?? "",
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
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Text(
                  newPrice.isNotEmpty ? newPrice.toString() + "  ر.س" : "",
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
                SizedBox(
                  width: 15,
                ),
                (productMap["value"].onSale && newRegularPrice.isNotEmpty)
                    ? Text(
                        newRegularPrice.toString() + "  ر.س",
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
              ],
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                productMap["value"].ratingCount == null
                    ? Container()
                    : RatingStars(
                        number: productMap["value"].ratingCount,
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 15,
                    bottom: 8,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showAddReviewForm(
                        context: context,
                        productId: productMap["value"].id,
                      );
                    },
                    child: Text(
                      "اضف تقيمك",
                      textDirection: TextDirection.rtl,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          !showPurchaseQuantity
              ? Container()
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_chart,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        purchaseQuantity,
                        textScaleFactor: 1,
                        textDirection: TextDirection.rtl,
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
                        "قطع تم شرائها",
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
                    ],
                  ),
                ),
          productMap["value"].stockQuantity == null
              ? Container()
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Text(
                        "الكمية المتاحة : ",
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
                        productMap["value"].stockQuantity.toString(),
                        textScaleFactor: 1,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
          vendorName.isEmpty
              ? Container()
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      const Text(
                        "بواسطة : ",
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
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new SellerProductsScreen(
                                vendorId: vendorId,
                                vendorName: vendorName,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          vendorName,
                          textScaleFactor: 1,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: 17,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
