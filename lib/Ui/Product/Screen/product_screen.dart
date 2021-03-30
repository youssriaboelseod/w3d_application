import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/ReviewsProvider/reviews_provider.dart';
import '../Widgets/body.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/product_screen";
  final Map<String, dynamic> productMap;

  const ProductScreen({Key key, this.productMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ReviewsProvider>(context, listen: false).resetReviews();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Body(
        productMap: productMap,
      ),
    );
  }
}
