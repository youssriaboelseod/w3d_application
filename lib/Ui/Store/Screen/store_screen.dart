import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
import '../../../Providers/ProductsProvider/products_provider.dart';
import '../../AddProduct/Screen/add_product_screen.dart';
import '../../MyProducts/Screen/my_products_screen.dart';
import '../Widgets/body.dart';
import '../../Drawer/Screen/drawer_screen.dart';
import '../../Home/Screen/home_screen.dart';
import '../../Cart/Screen/cart_screen.dart';
import '../../Search/Screen/search_screen.dart';

// ignore: must_be_immutable
class StoreScreen extends StatelessWidget {
  static const routeName = "/store_screen";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;

  void onTabTapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.of(context).pushReplacementNamed(MyProductsScreen.routeName);
    } else if (index == 1) {
      Navigator.of(context).pushReplacementNamed(StoreScreen.routeName);
    } else if (index == 2) {
      Navigator.of(context).pushReplacementNamed(AddProductScreen.routeName);
    } else if (index == 3) {
      Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
    } else if (index == 4) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  Future<void> fetchProductsForFirstTime(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProductsByCategory(
      categoryId: "0",
      resetCategoryPageNumber: true,
    );

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      drawer: DrawerApp(),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: fetchProductsForFirstTime(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
              ),
            );
          } else {
            return Body();
          }
        },
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      leading: IconButton(
        icon: Icon(
          Icons.filter_list,
          color: Colors.black,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      // On Android by default its false
      centerTitle: true,
      title: Container(
        width: 120,
        height: 90,
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: CupertinoColors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        if (_currentIndex == index) {
          return;
        } else {
          onTabTapped(index, context);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.person,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.store,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.store,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.add_circle,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          label: "",
        ),
      ],
    );
  }
}
