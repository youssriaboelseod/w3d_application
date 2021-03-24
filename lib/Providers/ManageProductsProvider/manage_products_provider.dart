import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'dart:math';
import 'package:woocommerce_api/woocommerce_api.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../Models/Product/product_model.dart';
import '../AuthDataProvider/auth_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class ManageProductsProvider with ChangeNotifier {
  String userUid;
  List<QueryDocumentSnapshot> downloadedProducts = [];
  String keys =
      "consumer_key=ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d&consumer_secret=cs_aa9486fe01e314e72b5b2d50ae109c84a682f749";

  WooCommerce woocommerce = WooCommerce(
    baseUrl: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );
  WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
    url: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final Map<String, String> headersMedia = {
    'Content-Type': 'image/png',
  };

  void setUserUid({String uid}) {
    userUid = uid;
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

  Future<String> createProduct({
    BuildContext context,
    Map productMap,
    String vendorId,
  }) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "لايوجد لديك انترنت";
    }

    try {
      String url = "https://050saa.com/wp-json/wcfmmp/v1/products/";
      http.Response response;

      String username = Provider.of<AuthDataProvider>(context, listen: false)
          .currentUser
          .userName;
      String password = Provider.of<AuthDataProvider>(context, listen: false)
          .currentUser
          .password;

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.post(
        url,
        headers: headerCreate,
        body: json.encode(
          productMap,
        ),
      );

      print(response.statusCode);
      //print(response.body);
      if (response.statusCode == 200) {
        return null;
      } else {
        return "لقد حدث خطأ";
      }
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    } on SocketException catch (_) {
      return "لايوجد لديك انترنت";
    } catch (e) {
      print(e);
      return "لقد حدث خطأ";
    }
  }

  // Upload image to firebase storage

  Future<String> uploadImageToServer({
    BuildContext context,
    File imageFile,
  }) async {
    try {
      String uploadUrl = "https://050saa.com/wp-json/app-image/images/?$keys";
      String fileName = basename(imageFile.path);

      Dio dio = new Dio();

      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });
      Response response = await dio.post(
        uploadUrl,
        data: data,
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      }

      return "";
    } on SocketException catch (_) {
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<String> deleteProduct({String productId}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }
    try {
      http.Response response;

      response = await http.delete(
        "https://050saa.com/wp-json/wc/v1/products/$productId?$keys",
        headers: headers,
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return null;
      } else {
        return "لقد حدث خطأ";
      }
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    } on SocketException catch (_) {
      return "No internet connection!";
    } catch (e) {
      return "Database problem";
    }
  }

  Future<String> updateProduct({
    BuildContext context,
    Map productMap,
    String productId,
    String vendorId,
  }) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "لايوجد لديك انترنت";
    }

    try {
      String url = "https://050saa.com/wp-json/wcfmmp/v1/products/$productId";
      http.Response response;

      String username = Provider.of<AuthDataProvider>(context, listen: false)
          .currentUser
          .userName;
      String password = Provider.of<AuthDataProvider>(context, listen: false)
          .currentUser
          .password;

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(productId);
      print(basicAuth);

      final Map<String, String> headerCreate = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      };

      response = await http.put(
        url,
        headers: headerCreate,
        body: json.encode(
          productMap,
        ),
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return null;
      } else {
        return "لقد حدث خطأ";
      }
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    } on SocketException catch (_) {
      return "لايوجد لديك انترنت";
    } catch (e) {
      print(e);
      return "لقد حدث خطأ";
    }
  }

  Future<String> fetchProductsFromFirebase(
      {@required BuildContext context}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }

    FirebaseFirestore fCF;

    try {
      return null;
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    } on SocketException catch (_) {
      return "No internet connection!";
    } catch (e) {
      return "Database problem";
    }
  }

  Future<void> updateAppDatabase({
    @required BuildContext context,
  }) async {
    // convert firebase data to type ProductModel
    List<ProductModel> products = [];
    ProductModel product;
    downloadedProducts.forEach((element) {
      product = ProductModel.fromFirebase(
        map: element.data(),
      );
      products.add(product);
    });

    // remove the previous data in app database and update it with the new data
    // await Provider.of<ProductsProvider>(context, listen: false)
    //   .updateAllTable(products);
  }
}
