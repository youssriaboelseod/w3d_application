import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../../Providers/ReviewsProvider/reviews_provider.dart';
import '../../Product/Widgets/body.dart';

class ProductViaDynamicLinkScreen extends StatefulWidget {
  static const routeName = "/product_via_dynamic_link";
  final String productId;

  ProductViaDynamicLinkScreen({Key key, this.productId}) : super(key: key);

  @override
  _ProductViaDynamicLinkScreenState createState() =>
      _ProductViaDynamicLinkScreenState();
}

class _ProductViaDynamicLinkScreenState
    extends State<ProductViaDynamicLinkScreen> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic> productMap;
  bool _isInit = false;
  Future<void> _future(BuildContext context) async {
    if (_isInit) {
      return;
    }
    productMap = await Provider.of<ProductsProvider>(context, listen: false)
        .getProductById(
      int.parse(widget.productId),
    );
    _isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<ReviewsProvider>(context, listen: false).resetReviews();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
          future: _future(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/loading_product.png",
                      fit: BoxFit.contain,
                      height: size.height,
                      width: size.width,
                    ),
                  ],
                ),
              );
            } else {
              if (productMap == null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.refresh_outlined,
                      size: 40,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isInit = false;
                      });
                    },
                  ),
                );
              } else {
                return Body(
                  productMap: productMap,
                );
              }
            }
          }),
    );
  }
}
