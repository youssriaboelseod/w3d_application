import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
//
import '../../Cart/Screen/cart_screen.dart';
import '../../Home/Screen/home_screen.dart';
import '../../Search/Screen/search_screen.dart';
import '../../Store/Screen/store_screen.dart';
import '../../Drawer/Screen/drawer_screen.dart';
import '../../AddProduct/Screen/add_product_screen.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../Authentication/Login/Screen/login_screen.dart';

import '../Widgets/body.dart';

// ignore: must_be_immutable
class MyProductsScreen extends StatelessWidget {
  static const routeName = "/my_products_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  String userId;
  List<Map<String, dynamic>> products = [];

  void onTabTapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.of(context).pushReplacementNamed(MyProductsScreen.routeName);
    } else if (index == 1) {
      Navigator.of(context).pushReplacementNamed(StoreScreen.routeName);
    } else if (index == 2) {
      Navigator.of(context).pushReplacementNamed(AddProductScreen.routeName);
    } else if (index == 3) {
      Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
    } else if (index == 4) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  Future<void> fetchProductsForFirstTime(BuildContext context) async {
    Provider.of<ProductsProvider>(context, listen: false).resetVendorProducts();

    userId =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;
    if (userId == null) {
      return;
    }

    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchVendorProducts(
      vendroId: userId,
    );
    products =
        Provider.of<ProductsProvider>(context, listen: false).vendorProducts;

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      drawer: DrawerApp(),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: fetchProductsForFirstTime(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(
                color: Colors.black,
              ),
            );
          } else {
            if (userId == null) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    "من فضلك قم بالتسجيل اولا",
                    textScaleFactor: 1,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              if (products.length == 0) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AddProductScreen.routeName);
                    },
                    child: Text(
                      "لايوجد لديك اي منتجات \n قم بأضافة منتجاتك",
                      textScaleFactor: 1,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else {
                return Body();
              }
            }
          }
        },
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      leading: IconButton(
        icon: Icon(
          Icons.filter_list,
          color: Colors.black,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      // On Android by default its false
      centerTitle: true,
      title: Container(
        width: 120,
        height: 90,
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: CupertinoColors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        if (_currentIndex == index) {
          return;
        } else {
          onTabTapped(index, context);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.person,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.store,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.store,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.add_circle,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
      ],
    );
  }
}
