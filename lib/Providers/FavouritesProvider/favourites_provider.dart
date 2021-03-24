import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../Models/Product/product_model.dart';
import '../../Database/app_database.dart';

class FavouritesProvider with ChangeNotifier {
  List<ProductModel> favouritesProducts = [];
  List<String> downloadedFavourites = [];

  Future<void> startFireBase() async {
    print("Starting firebase .......");
    await Firebase.initializeApp();
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

  Future<String> fetchAndSetFavouriteProductsFromFirebase({String uid}) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }

    try {
      // Intialize firebase
      await startFireBase();
      //
      FirebaseFirestore fCF;
      fCF = FirebaseFirestore.instance;

      QuerySnapshot snap;

      snap = await fCF
          .collection("Users")
          .doc(uid)
          .collection("UserData")
          .doc("UserFavourites")
          .collection("Favourites")
          .get();

      // Add favourites to app database
      snap.docs.forEach((element) async {
        await AppDB.insert("Favourites", element.data());
        ProductModel outProduct = await getProductByIdFromAppDatabase(
          productId: element.data()["productId"],
        );
        favouritesProducts.add(
          outProduct,
        );
      });

      return null;
    } on SocketException catch (_) {
      return "No internet connection!";
    } catch (e) {
      return "Database problem";
    }
  }

  Future<ProductModel> getProductByIdFromAppDatabase({String productId}) async {
    List<Map<String, dynamic>> outList = [];
    outList = await AppDB.select(
      table: "Products",
      whereStatement: "id = ?",
      whereValue: productId,
    );

    return ProductModel.fromAppDatabase(
      map: outList[0],
    );
  }

  Future<bool> fetchAndSetFavouriteProductsFromAppDatabase() async {
    List<Map<String, dynamic>> outList = [];
    outList = await AppDB.getData("Favourites");

    if (outList.length == 0) {
      return false;
    } else {
      outList.forEach((element) async {
        ProductModel outProduct = await getProductByIdFromAppDatabase(
            productId: element["productId"]);
        favouritesProducts.add(
          outProduct,
        );
      });
    }

    return true;
  }

  Future<void> addFavouriteProduct({ProductModel product}) async {
    await AppDB.insert(
      "Favourites",
      {
        "productId": product.id,
      },
    );
    favouritesProducts.add(product);
    //notifyListeners();
  }

  Future<void> removeFavouriteProduct({ProductModel product}) async {
    await AppDB.delete(
      table: "Favourites",
      whereStatement: "productId = ?",
      whereValue: product.id,
    );
    favouritesProducts.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  List<ProductModel> getFavouritesProducts() {
    return [...favouritesProducts];
  }

  bool checkIfFavourite({ProductModel productModel}) {
    bool check = false;
    favouritesProducts.forEach((element) {
      if (element.id == productModel.id) {
        check = true;
      }
    });
    return check;
  }

  Future<void> clearFavourites() async {
    await AppDB.clearTable(table: "Favourites");
    favouritesProducts.clear();
  }
}
