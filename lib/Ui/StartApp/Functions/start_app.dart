import 'package:flutter/cupertino.dart';
import 'package:w3d/Providers/ProductsProvider/products_provider.dart';
import '../../../Providers/AppConfigurationsProvider/app_configurations_provider.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../Providers/OrdersProvider/order_provider.dart';
import '../../../Providers/CartProvider/cart_provider.dart';
import 'package:provider/provider.dart';

Future<bool> startApp(BuildContext context) async {
  await Provider.of<AppConfigurationsProvider>(context, listen: false)
      .fetchAndSetTable();

  await Provider.of<AuthDataProvider>(context, listen: false)
      .fetchAndSetTable();
  String id =
      Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;
  // Set cart key == user's id
  Provider.of<CartProvider>(context, listen: false).setUid(
    uidInp: id,
  );
  Provider.of<OrdersProvider>(context, listen: false).setUid(
    uidInp: id,
  );

  // Fetch products
  String output = await Provider.of<ProductsProvider>(context, listen: false)
      .fetchAndSetProductsForHomePage();

  bool check = false;
  check =
      Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();

  return check;
}
