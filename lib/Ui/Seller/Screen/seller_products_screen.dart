import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import '../../Cart/Screen/cart_screen.dart';
import '../../Home/Screen/home_screen.dart';
import '../../Search/Screen/search_screen.dart';
import '../../Store/Screen/store_screen.dart';
import '../../Drawer/Screen/drawer_screen.dart';

import 'package:woocommerce/woocommerce.dart';

import '../../AddProduct/Screen/add_product_screen.dart';

import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
//
import '../Widgets/body.dart';

// ignore: must_be_immutable
class SellerProductsScreen extends StatelessWidget {
  static const routeName = "/seller_products_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  Future<void> fetchProductsForFirstTime(BuildContext context) async {
    Provider.of<ProductsProvider>(context, listen: false).resetVendorProducts();

    String userId =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;

    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchVendorProducts(
      vendroId: userId,
    );

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: fetchProductsForFirstTime(context),
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
            return Body();
          }
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      centerTitle: true,
      title: Text(
        "اسم المتجر",
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
      actions: [
        Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
