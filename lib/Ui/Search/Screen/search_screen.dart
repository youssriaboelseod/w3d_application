import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../Cart/Screen/cart_screen.dart';
import '../../AddProduct/Screen/add_product_screen.dart';
import '../../MyProducts/Screen/my_products_screen.dart';
import '../../Store/Screen/store_screen.dart';
import '../../Drawer/Screen/drawer_screen.dart';
import '../Widgets/body.dart';
import '../../Home/Screen/home_screen.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  static const routeName = "/search_screen";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 3;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar(context),
      drawer: DrawerApp(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Body(),
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
      currentIndex: 3,
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
