import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../Widgets/body.dart';

// ignore: must_be_immutable
class SellerProductsScreen extends StatelessWidget {
  final String vendorName;
  final String vendorId;
  SellerProductsScreen({
    Key key,
    this.vendorId,
    this.vendorName,
  }) : super(key: key);

  static const routeName = "/seller_products_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchProductsForFirstTime(BuildContext context) async {
    Provider.of<ProductsProvider>(context, listen: false).resetVendorProducts();

    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchVendorProducts(
      vendroId: vendorId,
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
              child: SpinKitChasingDots(
                color: Colors.black,
              ),
            );
          } else {
            return Body(
              vendorId: vendorId,
              vendorName: vendorName,
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
        vendorName,
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
