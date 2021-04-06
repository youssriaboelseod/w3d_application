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
  bool _isLoading = false;
  bool resetCategoryPageNumber = false;
  int selectedIndex = 0;

  void onChange(int index) async {
    if (_isLoading) {
      return;
    } else if (selectedIndex == index) {
      return;
    }
    setState(() {
      selectedIndex = index;
      _isLoading = true;
      resetCategoryPageNumber = true;
      _isShowLoadMore = true;
    });
    await getProductsAdvanced();
    resetCategoryPageNumber = false;
  }

  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    products = Provider.of<ProductsProvider>(context, listen: false)
        .getProductsByCategory();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getProductsAdvanced();
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

  getProductsAdvanced() async {
    if (_isFetchingMore && !_isLoading) {
      return;
    }
    tempLength = products.length;
    _isFetchingMore = true;

    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProductsByCategory(
      categoryId: mainCategories[selectedIndex]["id"],
      resetCategoryPageNumber: resetCategoryPageNumber,
    );

    setState(() {
      products = Provider.of<ProductsProvider>(context, listen: false)
          .getProductsByCategory();

      if (tempLength == products.length) {
        print("---------------false--------------");
        _isShowLoadMore = false;
      }
      _isLoading = false;
      _isFetchingMore = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = getRatio(size.width);
    print("----- Store products length --------");
    print(products.length);

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
        _isLoading
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                ),
                child: SpinKitChasingDots(
                  color: Colors.black,
                ),
              )
            : Expanded(
                child: ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  children: [
                    GridView(
                      padding: const EdgeInsets.all(2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              ),
      ],
    );
  }
}
