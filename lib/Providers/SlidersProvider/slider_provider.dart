import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SlidersProvider with ChangeNotifier {
  List<String> sliders = [];

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

  Future<String> fetchAndSetSliders() async {
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

      snap = await fCF.collection("Slider").get();

      snap.docs.forEach((element) async {
        sliders.add(element.data()["ImageUrl"]);
      });
      return null;
    } on SocketException catch (_) {
      return "No internet connection!";
    } catch (e) {
      return "Database problem";
    }
  }

  List<String> get getSliders {
    return [...sliders];
  }
}

// Categories will take id from ( c0 : c10 )
