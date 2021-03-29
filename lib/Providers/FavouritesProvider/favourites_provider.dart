import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w3d/Providers/ProductsProvider/products_provider.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';
import '../../Models/Product/product_model.dart';
import '../../Database/app_database.dart';

class FavouritesProvider with ChangeNotifier {
  WooCommerce woocommerce = WooCommerce(
    baseUrl: "https://050saa.com",
    consumerKey: "ck_da5c9ea679814a228bcd5cda0c3c1b932c98ff1d",
    consumerSecret: "cs_aa9486fe01e314e72b5b2d50ae109c84a682f749",
  );
  String uid = "";
  List<int> favouriteProductsIds = [];
  List<Map<String, dynamic>> favouriteProducts = [];

  Future<bool> checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      //Nothing to do --> continue in code
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  Future<bool> fetchAndSetFavouriteProductsFromAppDatabase() async {
    List<Map<String, dynamic>> outList = [];
    if (uid == null) {
      return false;
    }
    outList = await AppDB.select(
      table: "Favourites",
      whereStatement: "uid=?",
      whereArgs: [
        uid,
      ],
    );

    if (outList.length == 0) {
      return false;
    } else {
      favouriteProductsIds.clear();
      favouriteProducts.clear();
      outList.forEach((element) async {
        favouriteProductsIds.add(
          element["productId"],
        );
      });
    }

    return true;
  }

  Future<void> addFavouriteProduct({@required int productId}) async {
    await AppDB.insert(
      "Favourites",
      {
        "productId": productId,
        "uid": uid,
      },
    );
    favouriteProductsIds.add(productId);
    //notifyListeners();
  }

  Future<void> removeFavouriteProduct({@required int productId}) async {
    await AppDB.delete(
      table: "Favourites",
      whereStatement: "productId = ? AND uid = ?",
      whereArgs: [
        productId,
        uid,
      ],
    );
    favouriteProductsIds.removeWhere((element) => element == productId);
    int index = favouriteProducts
        .indexWhere((element) => element["value"].id == productId);
    if (index != -1) {
      favouriteProducts.removeAt(index);
    }

    notifyListeners();
  }

  List<int> getFavouritesProducts() {
    return [...favouriteProductsIds];
  }

  bool checkIfFavourite({int productId}) {
    bool check = false;
    favouriteProductsIds.forEach((element) {
      if (element == productId) {
        check = true;
      }
    });
    return check;
  }

  Future<void> clearFavourites() async {
    await AppDB.clearTable(
      table: "Favourites",
    );
    favouriteProductsIds.clear();
  }

  Future<List<Map<String, dynamic>>> fetchFavouritesProductsFromWooCommerce(
      {BuildContext context}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return [];
    }

    try {
      int counter = 0;
      favouriteProducts.clear();

      while (counter < favouriteProductsIds.length) {
        Map<String, dynamic> productMap =
            await Provider.of<ProductsProvider>(context, listen: false)
                .getProductById(
          favouriteProductsIds[counter],
        );

        counter += 1;
        if (productMap != null) {
          favouriteProducts.add(productMap);
        }
      }

      return favouriteProducts;
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  void setUid({String uidInp}) {
    uid = uidInp;
  }
}
