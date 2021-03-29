import 'package:flutter/material.dart';
import '../../../Providers/ProductsProvider/products_provider.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:provider/provider.dart';

import '../../1MainHelper/Helpers/helper.dart';

class CategoriesCard extends StatefulWidget {
  final ValueChanged<int> select;
  final int selectedIndex;

  const CategoriesCard({Key key, this.select, this.selectedIndex})
      : super(key: key);
  @override
  _CategoriesCardState createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.grey[400],
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            CategoryItemCard(
              isSelected: widget.selectedIndex == 0 ? true : false,
              select: widget.select,
              index: 0,
            ),
            Container(
              width: 1,
              color: Colors.grey[700],
            ),
            CategoryItemCard(
              isSelected: widget.selectedIndex == 1 ? true : false,
              select: widget.select,
              index: 1,
            ),
            Container(
              width: 1,
              color: Colors.grey[700],
            ),
            CategoryItemCard(
              isSelected: widget.selectedIndex == 2 ? true : false,
              select: widget.select,
              index: 2,
            ),
            Container(
              width: 1,
              height: 10,
              color: Colors.grey[700],
            ),
            CategoryItemCard(
              isSelected: widget.selectedIndex == 3 ? true : false,
              select: widget.select,
              index: 3,
            ),
            Container(
              width: 1,
              color: Colors.grey[700],
            ),
            CategoryItemCard(
              isSelected: widget.selectedIndex == 4 ? true : false,
              select: widget.select,
              index: 4,
            ),
            Container(
              width: 1,
              color: Colors.grey[700],
            ),
            CategoryItemCard(
              isSelected: widget.selectedIndex == 5 ? true : false,
              select: widget.select,
              index: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItemCard extends StatelessWidget {
  final String title;
  final WooProductCategory category;
  final bool isSelected;
  final ValueChanged<int> select;
  final int index;

  CategoryItemCard(
      {Key key,
      this.title,
      this.category,
      this.isSelected,
      this.select,
      this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        select(index);
      },
      key: ValueKey(
        mainCategories[index]["id"],
      ),
      child: Container(
        height: 44,
        color: isSelected ? Colors.grey[600] : Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          child: Center(
            child: Text(
              mainCategories[index]["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
