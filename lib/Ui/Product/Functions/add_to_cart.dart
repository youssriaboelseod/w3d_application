import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//
import '../../../Models/Cart/cart_model.dart';

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

Future<bool> addProductToCart(
    {BuildContext context, CartModel cartModel}) async {
  try {
    await startFireBase();
    bool check = await checkInternetConnection();
    if (!check) {
      return false;
    }

    return true;
  } catch (error) {
    print(error);
    // validate sign up process
    return false;
  }
}
