import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';

import 'package:woocommerce/woocommerce.dart';

import '../../../Providers/ProductsProvider/products_provider.dart';

//
import '../Widgets/body.dart';

// ignore: must_be_immutable
class SellerProductsScreen extends StatelessWidget {
  final WooCustomer vendorOfProduct;
  SellerProductsScreen({Key key, this.vendorOfProduct}) : super(key: key);

  static const routeName = "/seller_products_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchProductsForFirstTime(BuildContext context) async {
    Provider.of<ProductsProvider>(context, listen: false).resetVendorProducts();

    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchVendorProducts(
      vendroId: vendorOfProduct.id.toString(),
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
            return Body(
              vendorOfProduct: vendorOfProduct,
            );
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
        vendorOfProduct.username,
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
