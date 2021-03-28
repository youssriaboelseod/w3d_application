import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';
//
import '../Widgets/update_product_form.dart';

class UpdateProductScreen extends StatelessWidget {
  final WooProduct product;
  UpdateProductScreen({Key key, this.product}) : super(key: key);

  static const routeName = "/update_product_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          UpdateProductForm(
            product: product,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[200],
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      // On Android by default its false
      centerTitle: true,
      title: Text(
        "تعديل المنتج",
        textScaleFactor: 1,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Image.asset("assets/images/logo.png"),
      ],
    );
  }
}
