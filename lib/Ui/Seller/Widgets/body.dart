import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';
//
import '../../1MainHelper/Functions/main_functions.dart';
import '../../1MainHelper/Widgets/product_item_grid.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';

class Body extends StatefulWidget {
  final String vendorName;
  final String vendorId;
  const Body({
    Key key,
    this.vendorId,
    this.vendorName,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollController = new ScrollController();
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    products =
        Provider.of<ProductsProvider>(context, listen: false).vendorProducts;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  bool _isLoading = false;
  Future<void> fetchMoreProducts() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;

    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchVendorProducts(
      vendroId: widget.vendorId.toString(),
    );

    setState(() {
      products =
          Provider.of<ProductsProvider>(context, listen: false).vendorProducts;
      _isLoading = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = getRatio(size.width);

    return Consumer<ProductsProvider>(
      builder: (context, value, child) {
        products = value.vendorProducts;
        return GridView(
          padding: const EdgeInsets.all(2),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: ratio,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          controller: _scrollController,
          shrinkWrap: true,
          primary: false,
          children: List.generate(
            products.length,
            (index) => ProductItemGrid(
              productMap: products[index],
              key: ValueKey(
                products[index]["value"].id,
              ),
            ),
          ),
        );
      },
    );
  }
}
