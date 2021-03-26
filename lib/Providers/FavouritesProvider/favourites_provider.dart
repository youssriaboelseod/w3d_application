import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  List<int> favouriteProductsIds = [];
  List<WooProduct> favouriteProducts = [];

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
    outList = await AppDB.getData("Favourites");

    if (outList.length == 0) {
      return false;
    } else {
      favouriteProductsIds.clear();
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
      },
    );
    favouriteProductsIds.add(productId);
    //notifyListeners();
  }

  Future<void> removeFavouriteProduct({@required int productId}) async {
    await AppDB.delete(
      table: "Favourites",
      whereStatement: "productId = ?",
      whereValue: productId,
    );
    favouriteProductsIds.removeWhere((element) => element == productId);
    int index =
        favouriteProducts.indexWhere((element) => element.id == productId);
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

  Future<List<WooProduct>> fetchFavouritesProductsFromWooCommerce(
      {int page, String vendroId}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return [];
    }

    try {
      int counter = 0;
      favouriteProducts.clear();

      while (counter < favouriteProductsIds.length) {
        WooProduct fetchedProduct = await getProductById(
          favouriteProductsIds[counter],
        );
        counter += 1;
        if (fetchedProduct != null) {
          favouriteProducts.add(fetchedProduct);
        }
      }

      return favouriteProducts;
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<WooProduct> getProductById(int productId) async {
    WooProduct fetchedProduct;
    try {
      fetchedProduct = await woocommerce.getProductById(
        id: productId,
      );
    } on SocketException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
    return fetchedProduct;
  }
}
