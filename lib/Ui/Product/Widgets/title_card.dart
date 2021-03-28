import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3d/Providers/ProductsProvider/products_provider.dart';
import 'package:w3d/Ui/Product/Functions/add_review.dart';
import 'package:w3d/Ui/Product/Widgets/rating_stars.dart';
import 'package:w3d/Ui/Seller/Screen/seller_products_screen.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:google_fonts_arabic/fonts.dart';

class TitleCard extends StatelessWidget {
  final WooProduct productModel;
  final String newPrice;
  final String newRegularPrice;

  TitleCard({
    Key key,
    this.productModel,
    this.newPrice,
    this.newRegularPrice,
  }) : super(key: key);
  String purchaseQuantity = "";
  bool showPurchaseQuantity = true;
  String sellerName = "";
  WooCustomer vendorOfProduct;

  Future<void> getSellerName(BuildContext context) async {
    vendorOfProduct = await Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).getSellerName(
      productId: productModel.id,
      context: context,
    );
    if (vendorOfProduct != null) {
      sellerName = vendorOfProduct.username;
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      purchaseQuantity =
          productModel.priceHtml.split("class=\"items-sold-texts\" >")[1];

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
                (productModel.onSale && newRegularPrice.isNotEmpty)
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
                productModel.ratingCount == null
                    ? Container()
                    : RatingStars(
                        number: productModel.ratingCount,
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
                        productId: productModel.id,
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
          productModel.stockQuantity == null
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
                        productModel.stockQuantity.toString(),
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
          FutureBuilder(
            future: getSellerName(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                return sellerName.isEmpty
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
                                      vendorOfProduct: vendorOfProduct,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                sellerName,
                                textScaleFactor: 1,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
