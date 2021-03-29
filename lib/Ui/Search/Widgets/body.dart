import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../1MainHelper/Functions/main_functions.dart';
import 'search_card.dart';
import '../../1MainHelper/Widgets/product_item_grid.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, dynamic>> searchProducts = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  String searchValue = "";

  void search() async {
    if (searchValue.isEmpty) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    //
    searchProducts.clear();
    searchProducts = await Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).getProductsByName(searchValue);
    //
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ratio = getRatio(size.width);

    return Column(
      children: [
        SearchCard(
          onChange: (value) async {
            searchValue = value;
            search();
          },
        ),
        _isLoading
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.black,
                  ),
                ),
              )
            : Expanded(
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
                      productMap: searchProducts[index],
                      key: ValueKey(
                        searchProducts[index]["value"].id,
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
