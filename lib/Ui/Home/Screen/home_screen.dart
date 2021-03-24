import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:w3d/Ui/AddProduct/Screen/add_product_screen.dart';
import 'package:w3d/Ui/MyProducts/Screen/my_products_screen.dart';
import 'package:w3d/Ui/Profile/Screen/profile_screen.dart';
import 'package:w3d/Ui/Search/Screen/search_screen.dart';
//
import '../../Store/Screen/store_screen.dart';
import '../../Drawer/Screen/drawer_screen.dart';
import '../Widgets/body.dart';
import '../../Favourites/Screen/favourites_screen.dart';
import '../../Cart/Screen/cart_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  static const routeName = "/home_screen";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 4;

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
      appBar: buildAppBar(context),
      drawer: DrawerApp(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.grey[200],
          child: Body(),
        ),
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
      currentIndex: 4,
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
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.person,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.store,
            size: 30,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.store,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle,
            size: 30,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.add_circle,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.search,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.home,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "",
        ),
      ],
    );
  }
}
