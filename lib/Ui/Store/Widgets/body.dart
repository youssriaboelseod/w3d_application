import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
//
import '../../1MainHelper/Functions/main_functions.dart';
import 'category_item_card.dart';
import '../../1MainHelper/Widgets/product_item_grid.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../1MainHelper/Helpers/helper.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollController = new ScrollController();

  List<Map<String, dynamic>> products = [];

  int selectedIndex = 0;

  void onChange(int index) async {
    if (selectedIndex == index) {
      return;
    } else {
      setState(() {
        selectedIndex = index;
        _isInit = false;
        _isShowLoadMore = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // These to show is loading more
  bool _isShowLoadMore = true;
  int tempLength;

  bool _isFetchingMore = false;

  fetchMoreProducts() async {
    if (_isFetchingMore) {
      return;
    }
    tempLength = products.length;
    _isFetchingMore = true;

    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProductsByCategory(
      categoryId: mainCategories[selectedIndex]["id"],
      resetCategoryPageNumber: false,
    );

    products = Provider.of<ProductsProvider>(context, listen: false)
        .getProductsByCategory();

    // This is to avoid duplicates elements in a list
    // List<Map<String, dynamic>> tempList = products;
    //products.map((e) => e["value"].id).toList();
    //products = tempList.toSet().toList();

    if (tempLength == products.length) {
      _isShowLoadMore = false;
    }

    _isFetchingMore = false;
    //  To preview the reset of fetched products
    setState(() {});
    return;
  }

  bool _isInit = false;
  Future<void> fetchProductsForFirstTime() async {
    if (_isInit) {
      return;
    } else {
      print("again");
      print(_isInit);
      // Clear
      products.clear();
      // Then fetch
      await Provider.of<ProductsProvider>(context, listen: false)
          .fetchProductsByCategory(
        categoryId: mainCategories[selectedIndex]["id"],
        resetCategoryPageNumber: true,
      );
      // Then get
      products = Provider.of<ProductsProvider>(context, listen: false)
          .getProductsByCategory();
      print("----- Store products length --------");
      print(products.length);

      // set _isinit to confirm fetching data for first time only
      _isInit = true;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = getRatio(size.width);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 14,
              ),
              child: Text(
                "التصنيفات",
                textScaleFactor: 1,
                style: TextStyle(
                  fontFamily: 'Raphtalia',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        CategoriesCard(
          select: onChange,
          selectedIndex: selectedIndex,
        ),
        FutureBuilder(
          future: fetchProductsForFirstTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !_isInit) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 120,
                ),
                child: SpinKitChasingDots(
                  color: Colors.black,
                ),
              );
            } else {
              return !_isInit
                  ? Container()
                  : Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        controller: _scrollController,
                        children: [
                          GridView(
                            padding: const EdgeInsets.all(2),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: ratio,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            shrinkWrap: true,
                            primary: false,
                            children: List.generate(
                              products.length,
                              (index) => ProductItemGrid(
                                productMap: products[index],
                                key: ValueKey(
                                  products[index]["value"].id,
                                ),
                              ),
                            ),
                          ),
                          products.length < 8
                              ? Container()
                              : !_isShowLoadMore
                                  ? Container()
                                  : Text(
                                      "جاري تحميل المزيد",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                        ],
                      ),
                    );
            }
          },
        ),
      ],
    );
  }
}
