import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:woocommerce/models/order.dart';
//
import '../Widgets/order_form.dart';

// ignore: must_be_immutable
class OrderScreen extends StatelessWidget {
  final WooOrder order;

  static const routeName = "/order_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrderScreen({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      backgroundColor: Colors.grey[200],
      body: OrderForm(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      // On Android by default its false
      centerTitle: true,
      title: Text(
        order.number,
        textScaleFactor: 1,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
          fontSize: 18,
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
