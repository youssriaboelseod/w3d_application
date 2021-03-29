import 'package:flutter/material.dart';
//
import '../Widgets/body.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/product_screen";
  final Map<String, dynamic> productMap;

  const ProductScreen({Key key, this.productMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Body(
        productMap: productMap,
      ),
    );
  }
}
