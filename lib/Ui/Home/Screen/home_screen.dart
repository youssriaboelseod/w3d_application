import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//
import '../../Store/Screen/store_screen.dart';
import '../../AddProduct/Screen/add_product_screen.dart';
import '../../MyProducts/Screen/my_products_screen.dart';
import '../../Search/Screen/search_screen.dart';
import '../../Drawer/Screen/drawer_screen.dart';
import '../Widgets/body.dart';
import '../../ProductThroughDynamicLink/Screen/product_via_dl_screen.dart';
import '../../Cart/Screen/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  void initState() {
    super.initState();
    this.initDynamicLinks(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isOpenedDynamicLink = false;

  void initDynamicLinks(BuildContext context) async {
    if (_isOpenedDynamicLink) {
      return;
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        if (deepLink.queryParameters.containsKey('id')) {
          String id = deepLink.queryParameters['id'];

          print("Product ID that has been received == ");
          print(id);
          deepLink = null;
          _isOpenedDynamicLink = true;
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new ProductViaDynamicLinkScreen(
                productId: id,
              ),
            ),
          );
        } else {
          // nothing to do
        }
        //Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri deepLink = data?.link;

    if (deepLink != null) {
      if (deepLink.queryParameters.containsKey('id')) {
        String id = deepLink.queryParameters['id'];
        print("Product ID that has been received == ");
        print(id);
        deepLink = null;
        _isOpenedDynamicLink = true;
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new ProductViaDynamicLinkScreen(
              productId: id,
            ),
          ),
        );
      } else {
        // nothing to do
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      drawer: DrawerApp(),
      backgroundColor: Colors.grey[200],
      body: Body(),
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
