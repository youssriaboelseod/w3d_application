import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../../../Providers/DynamicLinksProvider/dynamic_links_provider.dart';
import '../Widgets/body.dart';
import '../../../ProductViaDynamicLink/Screen/product_via_dl_screen.dart';

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

  void initDynamicLinks(BuildContext context) async {
    bool _isOpenedDynamicLink =
        Provider.of<DynamicLinksProvider>(context, listen: false)
            .isOpenedDynamicLink;

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

          // set is opended dynamic link true, To avoid open the page again
          Provider.of<DynamicLinksProvider>(context, listen: false)
              .setIsOpenedDynamicLink();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ProductViaDynamicLinkScreen(
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

        // set is opended dynamic link true, To avoid open the page again
        Provider.of<DynamicLinksProvider>(context, listen: false)
            .setIsOpenedDynamicLink();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ProductViaDynamicLinkScreen(
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
