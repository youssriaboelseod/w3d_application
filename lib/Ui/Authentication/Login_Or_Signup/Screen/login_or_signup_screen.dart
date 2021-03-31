import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
//
import '../Widgets/body.dart';
import '../../../ProductThroughDynamicLink/Screen/product_via_dl_screen.dart';

class LoginOrSignupScreen extends StatefulWidget {
  static const routeName = "login_or_signup_screen";

  @override
  _LoginOrSignupScreenState createState() => _LoginOrSignupScreenState();
}

class _LoginOrSignupScreenState extends State<LoginOrSignupScreen> {
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
      body: Body(),
    );
  }
}
