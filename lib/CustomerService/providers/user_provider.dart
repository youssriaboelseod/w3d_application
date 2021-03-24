import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  FirebaseFirestore fCF;
  FirebaseAuth fA;
  int numberOfUsersInWaitingQueue;
  DateTime registerDate;
  int userNumberInQueue;
  bool checkAvailableState;
  String userIdInQueue;

  Future<void> startFireBase() async {
    print("Starting firebase .......");
    await Firebase.initializeApp();
    fCF = FirebaseFirestore.instance;
    fA = FirebaseAuth.instance;
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

  Future<String> userAuthentication({String email, String password}) async {
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }
    try {
      final response = await fA.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.credential != null) {
        return "Wrong email or password";
      } else {
        return null;
      }
    } on SocketException catch (_) {
      return "No internet connection!";
    } catch (error) {
      return "Database problem";
    }
  }

  Future<bool> availableState() async {
    // this is condition if true , it will allow add clints in the waiting queue
    // if false, that will mean, we(the company) aren't available right now

    DocumentSnapshot stateDoc;
    try {
      stateDoc = await fCF
          .collection("QueueOfClients")
          .doc("CompanyAvailabilityState")
          .get();
      return stateDoc.data()["State"];
    } on SocketException catch (_) {
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<Map> registerInQueue({String email, String password}) async {
    String checkAuth;

    try {
      await startFireBase();

      checkAuth = await userAuthentication(email: email, password: password);
      if (checkAuth != null) {
        return {
          "State": false,
          "Output": checkAuth,
        };
      }

      checkAvailableState = await availableState();
      if (!checkAvailableState) {
        return {
          "State": false,
          "Output": "We aren't available right now",
        };
      }

      registerDate = DateTime.now();
      final DocumentReference document = await fCF
          .collection("QueueOfClients")
          .doc("MainDocument")
          .collection("WaitingQueue")
          .add({
        "RegisterDate": Timestamp.fromDate(registerDate),
      });

      userIdInQueue = document.id;

      return {
        "State": true,
        "Output": "Successful",
      };
    } on SocketException catch (_) {
      return {
        "State": false,
        "Output": "No internet connection",
      };
    } catch (error) {
      return {
        "State": false,
        "Output": "Datebase problem",
      };
    }
  }

  Future<int> getNumberOfClientsInQueue() async {
    try {
      await fCF
          .collection("QueueOfClients")
          .doc("MainDocument")
          .collection("WaitingQueue")
          .get()
          .then((snapShot) {
        // - 1 to remove the number of the initial document
        numberOfUsersInWaitingQueue = snapShot.docs.length - 1;
      });
      return numberOfUsersInWaitingQueue;
    } on SocketException catch (_) {
      return null;
    } catch (error) {
      return null;
    }
  }

  DateTime get registerDateFn {
    return registerDate;
  }

  void setUserNumber(int number) {
    userNumberInQueue = number;
    notifyListeners();
  }

  String get chatId {
    return userIdInQueue;
  }
}
