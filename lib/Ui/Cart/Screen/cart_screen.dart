import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//
import '../Widgets/body.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  static const routeName = "/cart_screen";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      backgroundColor: Colors.grey[200],
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[200],
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 35,
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
    );
  }
}
