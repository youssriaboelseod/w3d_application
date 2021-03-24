import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../../Providers/FavouritesProvider/favourites_provider.dart';
import '../../../Providers/AuthDataProvider/auth_data_provider.dart';
import '../../../Models/Product/product_model.dart';

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

Future<bool> addFavouriteProduct(
    {BuildContext context, ProductModel product}) async {
  try {
    await startFireBase();
    bool check = await checkInternetConnection();
    if (!check) {
      return false;
    }
    String uid =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;

    return true;
  } catch (error) {
    print(error);
    // validate sign up process
    return false;
  }
}

Future<bool> removeFavouriteProduct(
    {BuildContext context, ProductModel product}) async {
  try {
    await startFireBase();
    bool check = await checkInternetConnection();
    if (!check) {
      return false;
    }
    String uid =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;

    return true;
  } catch (error) {
    print(error);
    // validate sign up process
    return false;
  }
}
