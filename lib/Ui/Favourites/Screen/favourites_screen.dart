import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Models/Category/category.dart';
//
import '../Widgets/body.dart';
import '../../Store/Screen/store_screen.dart';
import '../../Home/Screen/home_screen.dart';
import '../../Drawer/Screen/drawer_screen.dart';
import '../../Cart/Screen/cart_screen.dart';

// ignore: must_be_immutable
class FavouritesScreen extends StatelessWidget {
  static const routeName = "/favourites_screen";

  final CategoryModel categoryModel;
  FavouritesScreen({Key key, this.categoryModel}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 2;

  void onTabTapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else if (index == 1) {
      Navigator.of(context).pushReplacementNamed(StoreScreen.routeName);
    } else if (index == 2) {
      Navigator.of(context).pushReplacementNamed(FavouritesScreen.routeName);
    } else if (index == 3) {
      Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
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

  AppBar buildAppBar() {
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
        width: 200,
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
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
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.home,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "الرئيسة",
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
          label: "السوق",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 30,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.favorite,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "المفضلة",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: CupertinoColors.activeGreen,
          ),
          label: "سلة المشتريات",
        ),
      ],
    );
  }
}
