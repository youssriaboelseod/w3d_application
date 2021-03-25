import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../Widgets/image_switcher_card.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../1MainHelper/Widgets/featured_product_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<WooProduct> homePageSouqProducts =
        Provider.of<ProductsProvider>(context, listen: false)
            .homePageSouqProducts;
    List<WooProduct> homePageMostViewedProducts =
        Provider.of<ProductsProvider>(context, listen: false)
            .homePageMostViewedProducts;
    List<WooProduct> homePagePopularProducts =
        Provider.of<ProductsProvider>(context, listen: false)
            .homePagePopularProducts;
    List<WooProduct> featuredProdcuts =
        Provider.of<ProductsProvider>(context, listen: false).onSaleProducts;

    return SingleChildScrollView(
      child: Column(
        children: [
          FeaturedProductsFrame(
            title: "العروض",
            products: featuredProdcuts,
          ),
          FeaturedProductsFrame(
            title: "أحدث الزيارات",
            products: homePageMostViewedProducts,
          ),
          FeaturedProductsFrame(
            title: "الأكثر رواجا",
            products: homePagePopularProducts,
          ),
          FeaturedProductsFrame(
            title: "السوق",
            products: homePageSouqProducts,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FeaturedProductsFrame extends StatelessWidget {
  final List<WooProduct> products;
  final String title;

  const FeaturedProductsFrame({Key key, this.products, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  right: 14,
                ),
                child: Text(
                  title,
                  textScaleFactor: 1,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 260,
            width: size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return FeaturedProductCard(
                  product: products[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
