import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UploadMessageProvider with ChangeNotifier {
  //this to upload messages to firebase
  String chatId;
  FirebaseFirestore fCF;

  Future<bool> checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      //Nothing to do --> continue in code
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  Future<String> uploadMessage(String message, DateTime sendDate) async {
    bool check = await checkInternetConnection();

    if (!check) {
      return "No internet connection!";
    }
    try {
      fCF = FirebaseFirestore.instance;
      await fCF.collection("Chats").doc(chatId).collection("ChatMessages").add(
        {
          "Message": message,
          "SendDate": Timestamp.fromDate(sendDate),
          "SenderType": "Client",
        },
      );
      return null;
    } on SocketException catch (_) {
      return "No internet connection!";
    } catch (_) {
      return "Database problem";
    }
  }

  void setChatId(String id) {
    chatId = id;
  }
}
