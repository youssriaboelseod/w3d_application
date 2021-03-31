import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/FavouritesProvider/favourites_provider.dart';
import '../../1MainHelper/Functions/main_functions.dart';
import '../../1MainHelper/Widgets/product_item_grid.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, dynamic>> favouritesProductsList = [];

  bool _isInit = false;

  Future<void> fetchFavouritesProducts(BuildContext context) async {
    if (_isInit) {
      return;
    }
    favouritesProductsList =
        await Provider.of<FavouritesProvider>(context, listen: false)
            .fetchFavouritesProductsFromWooCommerce(
      context: context,
    );
    _isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = getRatio(size.width);
    return FutureBuilder(
      future: fetchFavouritesProducts(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          );
        } else {
          if (favouritesProductsList.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        setState(() {
                          _isInit = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "لا يوجد لديك اي منتجات مفضلة",
                      textScaleFactor: 1,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Consumer<FavouritesProvider>(
            builder: (context, value, child) {
              favouritesProductsList = value.favouriteProducts;
              return GridView(
                padding: const EdgeInsets.all(2),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: ratio,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                primary: false,
                children: List.generate(
                  favouritesProductsList.length,
                  (index) => ProductItemGrid(
                    productMap: favouritesProductsList[index],
                    key: ValueKey(
                      favouritesProductsList[index]["value"].id,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
