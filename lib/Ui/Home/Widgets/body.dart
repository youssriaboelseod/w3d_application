import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts_arabic/fonts.dart';
//
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../1MainHelper/Widgets/featured_product_card.dart';
import '../../Sales/Screen/sales_products_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<int> numbers = [];
  bool refresh = false;

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
    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () async {
        Provider.of<ProductsProvider>(context, listen: false)
            .resetHomePageProducts();
        setState(() {
          refresh = true;
        });
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            FeaturedProductsFrame(
              title: "العروض",
              type: "onSale",
              refresh: refresh,
              isShowMore: true,
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
              refresh: refresh,
              isShowMore: false,
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
              refresh: refresh,
              isShowMore: false,
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
              isShowMore: false,
              refresh: refresh,
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
      ),
    );
  }
}

// ignore: must_be_immutable
class FeaturedProductsFrame extends StatelessWidget {
  final String title;
  final String type;
  final bool refresh;
  final bool isShowMore;

  final Future<dynamic> Function() function;

  FeaturedProductsFrame({
    Key key,
    this.title,
    this.function,
    this.type,
    this.refresh,
    this.isShowMore,
  }) : super(key: key);

  List<Map<String, dynamic>> products = [];

  Future<void> future(BuildContext context) async {
    // Check if there is already products
    getProducts(context);

    if (products.length != 0 && !refresh) {
      return;
    } else {
      await function();
      getProducts(context);
    }
  }

  void getProducts(BuildContext context) {
    if (type == "onSale") {
      products = Provider.of<ProductsProvider>(context, listen: false)
          .homePageOnSaleProducts;
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
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
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
                !isShowMore ? Container() : Spacer(),
                !isShowMore
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SalesProductsScreen.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 12,
                          ),
                          child: Text(
                            "مشاهدة المزيد",
                            textScaleFactor: 1,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          FutureBuilder(
            future: future(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 220,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: PlayStoreShimmer(),
                  ),
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
