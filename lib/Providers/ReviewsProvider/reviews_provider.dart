import 'dart:io';
import 'dart:io';
import 'package:provider/provider.dart';
import '../AuthDataProvider/auth_data_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'dart:math';

class ReviewsProvider with ChangeNotifier {
  String username = "auth@gmail.com";
  String password = "ASD123456zxc#";

  WooCommerce woocommerce = WooCommerce(
    baseUrl: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );

  Future<bool> checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      //Nothing to do --> continue in code
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  Future<List<WooProductReview>> getProductReviews(
      {int productId, BuildContext context}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return null;
    }
    try {
      http.Response response;

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);
      print(productId);

      String url =
          "https://050saa.com/wp-json/wc/v3/products/reviews/?product_id=$productId";

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.get(
        url,
        headers: headerCreate,
      );
      print("Status Code: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final outputProduct = json.decode(response.body);
        print(outputProduct);
        print(outputProduct.length);
        outputProduct.forEach((k, v) {
          print(k);
          print(v);
        });

        return [];
      } else {
        return null;
      }
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<WooProductReview>> createReview(
      {int productId, BuildContext context, String review}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return null;
    }
    try {
      http.Response response;

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);
      print(productId);

      String url =
          "https://050saa.com/wp-json/wc/v3/products/reviews/?product_id=$productId";

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.get(
        url,
        headers: headerCreate,
      );
      print("Status Code: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final outputProduct = json.decode(response.body);
        print(outputProduct);
        print(outputProduct.length);
        outputProduct.forEach((k, v) {
          print(k);
          print(v);
        });

        return [];
      } else {
        return null;
      }
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }
}
