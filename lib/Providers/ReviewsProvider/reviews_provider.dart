import 'dart:io';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
//
import '../AuthDataProvider/auth_data_provider.dart';

class ReviewsProvider with ChangeNotifier {
  String username = "auth@gmail.com";
  String password = "ASD123456zxc#";

  WooCommerce woocommerce = WooCommerce(
    baseUrl: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );

  List<WooProductReview> reviews = [];

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
      // Clear reviews
      reviews.clear();

      http.Response response;

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);
      print(productId);

      String url =
          "https://050saa.com//wp-json/wc/v3/products/reviews?product=$productId";

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

        outputProduct.forEach((element) {
          WooProductReview review = WooProductReview.fromJson(element);
          reviews.add(review);
        });
        notifyListeners();
        return reviews;
      } else {
        return [];
      }
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<String> createReview(
      {int productId, BuildContext context, String review, int rating}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "لايوجد لديك اتصال بالانترنت";
    }
    try {
      String userName = Provider.of<AuthDataProvider>(context, listen: false)
          .currentUser
          .userName;
      String email = Provider.of<AuthDataProvider>(context, listen: false)
          .currentUser
          .email;

      Map body = {
        'product_id': productId,
        'review': review,
        'reviewer': userName,
        'reviewer_email': email,
        'rating': rating,
      };
      http.Response response;

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));

      String url = "https://050saa.com/wp-json/wc/v3/products/reviews";

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.post(
        url,
        headers: headerCreate,
        body: json.encode(body),
      );
      print("Status Code: " + response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final outputData = json.decode(response.body);
        print(outputData);
        WooProductReview review = WooProductReview.fromJson(outputData);
        reviews.add(review);

        notifyListeners();
        return null;
      } else {
        return "لقد حدث خطأ من فضلك حاول مرة اخرى";
      }
    } on SocketException catch (_) {
      return "لايوجد لديك اتصال بالانترنت";
    } catch (e) {
      return "لقد حدث خطأ من فضلك حاول مرة اخرى";
    }
  }

  void resetReviews() {
    reviews.clear();
  }
}
