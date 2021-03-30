import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../1MainHelper/Widgets/featured_product_card.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  List<int> numbers = [];
  final random = new Random();
  int randomNumber;
  bool checkIfExist(int numberInp) {
    int index = numbers.indexOf(numberInp);
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  int getRandomNumber(int range) {
    randomNumber = random.nextInt(range);
    if (randomNumber == 0) {
      randomNumber += 1;
    }
    while (checkIfExist(randomNumber)) {
      randomNumber = random.nextInt(range);
      if (randomNumber == 0) {
        randomNumber += 1;
      }
    }
    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FeaturedProductsFrame(
            title: "العروض",
            type: "onSale",
            function: () async {
              randomNumber = getRandomNumber(5);
              numbers.add(randomNumber);
              print("My random number is = " + randomNumber.toString());
              await Provider.of<ProductsProvider>(context, listen: false)
                  .fetchAndSetProducts(
                pageNumber: randomNumber.toString(),
                perPage: "8",
                onSale: "true",
                type: "onSale",
              );
            },
          ),
          FeaturedProductsFrame(
            title: "أحدث الزيارات",
            type: "mostViewd",
            function: () async {
              randomNumber = getRandomNumber(14);

              numbers.add(randomNumber);
              print("My random number is = " + randomNumber.toString());
              await Provider.of<ProductsProvider>(context, listen: false)
                  .fetchAndSetProducts(
                pageNumber: randomNumber.toString(),
                perPage: "8",
                onSale: "false",
                type: "mostViewd",
              );
            },
          ),
          FeaturedProductsFrame(
            title: "الأكثر رواجا",
            type: "popular",
            function: () async {
              randomNumber = getRandomNumber(14);

              numbers.add(randomNumber);
              print("My random number is = " + randomNumber.toString());
              await Provider.of<ProductsProvider>(context, listen: false)
                  .fetchAndSetProducts(
                pageNumber: randomNumber.toString(),
                perPage: "8",
                onSale: "false",
                type: "popular",
              );
            },
          ),
          FeaturedProductsFrame(
            title: "السوق",
            type: "souq",
            function: () async {
              randomNumber = getRandomNumber(14);
              numbers.add(randomNumber);
              print("My random number is = " + randomNumber.toString());
              await Provider.of<ProductsProvider>(context, listen: false)
                  .fetchAndSetProducts(
                pageNumber: randomNumber.toString(),
                perPage: "8",
                onSale: "false",
                type: "souq",
              );
            },
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FeaturedProductsFrame extends StatelessWidget {
  final String title;
  final String type;
  final Future<dynamic> Function() function;

  FeaturedProductsFrame({Key key, this.title, this.function, this.type})
      : super(key: key);

  List<Map<String, dynamic>> products = [];

  Future<void> future(BuildContext context) async {
    // Check if there is already products
    getProducts(context);

    if (products.length != 0) {
      return;
    } else {
      await function();
      getProducts(context);
    }
  }

  void getProducts(BuildContext context) {
    if (type == "onSale") {
      products =
          Provider.of<ProductsProvider>(context, listen: false).onSaleProducts;
    } else if (type == "mostViewd") {
      products = Provider.of<ProductsProvider>(context, listen: false)
          .homePageMostViewedProducts;
    } else if (type == "popular") {
      products = Provider.of<ProductsProvider>(context, listen: false)
          .homePagePopularProducts;
    } else if (type == "souq") {
      products = Provider.of<ProductsProvider>(context, listen: false)
          .homePageSouqProducts;
    }
  }

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
          FutureBuilder(
            future: future(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 220,
                  child: PlayStoreShimmer(),
                );
              } else {
                return Container(
                  height: 260,
                  width: size.width,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return FeaturedProductCard(
                          productMap: products[index],
                          index: index,
                        );
                      },
                    ),
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
