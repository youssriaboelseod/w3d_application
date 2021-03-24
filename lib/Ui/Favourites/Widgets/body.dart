import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/Product/product_model.dart';
import '../../../Providers/FavouritesProvider/favourites_provider.dart';

import '../../../Models/Category/category.dart';
import 'search_card.dart';

class Body extends StatefulWidget {
  final CategoryModel categoryModel;

  const Body({Key key, this.categoryModel}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  List<ProductModel> favouriteProducts = [];
  List<ProductModel> searchProducts = [];

  String searchValue = '';

  void search() {
    searchProducts.clear();

    if (searchValue.isEmpty) {
      searchProducts = favouriteProducts;
      return;
    }

    favouriteProducts.forEach((element) {
      if (element.name.toLowerCase().contains(searchValue.toLowerCase())) {
        searchProducts.add(element);
      }
    });
    print(searchProducts.length);
  }

  @override
  Widget build(BuildContext context) {
    // Perform search
    search();
    return Column(
      children: [
        SearchCard(
          onChange: (value) {
            setState(() {
              searchValue = value;
            });
          },
        ),
        Consumer<FavouritesProvider>(
          builder: (context, value, child) {
            favouriteProducts = value.getFavouritesProducts();

            search();
            return searchProducts.length == 0
                ? Container()
                : Expanded(
                    child: ListView.builder(
                      itemCount: searchProducts.length,
                      itemBuilder: (context, index) {
                        return;
                      },
                    ),
                  );
          },
        ),
      ],
    );
  }
}
