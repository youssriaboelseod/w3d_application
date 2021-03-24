import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';
import '../../../Models/Product/product_model.dart';
//
import '../Widgets/body.dart';
import '../../1MainHelper/Functions/main_functions.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/product_screen";
  final WooProduct productModel;

  const ProductScreen({Key key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Body(
          productModel: productModel,
        ),
      ),
    );
  }
}
