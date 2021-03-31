import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
//
import '../../../../Models/UserAuthModel/user_auth_model.dart';
import '../../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../../Providers/CartProvider/cart_provider.dart';
import '../../../../Providers/FavouritesProvider/favourites_provider.dart';
import '../../../../Providers/OrdersProvider/order_provider.dart';

// Note:
// Here we will write the login fucntion
Future<String> loginWithEmailAndPassword({
  BuildContext context,
  UserAuthModel userAuthModel,
}) async {
  // Check internet connection
  bool check = await checkInternetConnection();
  String output;

  if (!check) {
    return "لايوجد لديك انترنت";
  }

  try {
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      "https://050saa.com/wp-json/app-login/login",
      body: jsonEncode(
        {
          "username": userAuthModel.email,
          "password": userAuthModel.password,
        },
      ),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      Map outMap = json.decode(response.body);

      await Provider.of<AuthDataProvider>(context, listen: false)
          .updateAuthDataTable(
        userAuthModelInp: UserAuthModel.fromWooCommerce(
          map: outMap,
          passwordInp: userAuthModel.password,
        ),
      );
      // Set cart key == user's id
      Provider.of<CartProvider>(context, listen: false).setUid(
        uidInp: outMap["ID"].toString(),
      );

      Provider.of<OrdersProvider>(context, listen: false).setUid(
        uidInp: outMap["ID"].toString(),
      );
      Provider.of<FavouritesProvider>(context, listen: false).setUid(
        uidInp: outMap["ID"].toString(),
      );

      await Provider.of<FavouritesProvider>(context, listen: false)
          .fetchAndSetFavouriteProductsFromAppDatabase();

      output = null;
    } else {
      if (response.body.contains("incorrect_password")) {
        output = "الباسورد غير صحيح";
      } else if (response.body.contains("invalid_username")) {
        output = "اسم المستخدم غير صحيح";
      } else if (response.body.contains("invalid_email")) {
        output = "البريد الالكتروني غير صحيح";
      } else {
        output = "لقد حدث خطأ";
      }
    }
    return output;
  } on SocketException catch (_) {
    return "لايوجد لديك انترنت";
  } catch (e) {
    return "لقد حدث خطأ";
  }
}

Future<bool> checkInternetConnection() async {
  try {
    await InternetAddress.lookup('google.com');
    //Nothing to do --> continue in code
  } on SocketException catch (_) {
    return false;
  }
  return true;
}
