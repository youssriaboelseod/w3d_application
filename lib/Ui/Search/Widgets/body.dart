import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';
import '../../../Models/Product/product_model.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../1MainHelper/Functions/main_functions.dart';
import 'search_card.dart';
import '../../1MainHelper/Widgets/product_item_grid.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<WooProduct> allProducts = [];
  List<WooProduct> searchProducts = [];
  @override
  void initState() {
    super.initState();
  }

  String searchValue = "";

  void search() {
    allProducts = Provider.of<ProductsProvider>(context, listen: false)
        .getProductsByCategory(
      categoryId: "0",
    );

    searchProducts.clear();
    if (searchValue.isEmpty) {
      searchProducts = allProducts;
      return;
    }

    allProducts.forEach((element) {
      if (element.name.toLowerCase().contains(searchValue.toLowerCase())) {
        searchProducts.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = getRatio(size.width);

    // Perform search
    search();
    return Column(
      children: [
        SearchCard(
          onChange: (value) {
            setState(
              () {
                searchValue = value;
              },
            );
          },
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: ratio,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            shrinkWrap: true,
            primary: false,
            itemCount: searchProducts.length,
            itemBuilder: (context, index) {
              return ProductItemGrid(
                product: searchProducts[index],
                key: ValueKey(
                  searchProducts[index].id,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
