import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Providers/AuthDataProvider/auth_data_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';

import '../Widgets/chat_messages_block.dart';

import '../Widgets/input_field.dart';
import '../../1MainHelper/Colors/colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chat-screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool chatAvailablity = true;
  String chatId;
  bool checkSetUserUid = false;

  @override
  void initState() {
    super.initState();
    chatId = Provider.of<UserProvider>(context, listen: false).chatId;

    Stream<QuerySnapshot> chatStream;
    // ignore: deprecated_member_use
    chatStream = Firestore.instance
        .collection("Chats")
        .doc(chatId)
        .collection("ChatDetails")
        .snapshots();
    chatStream.listen((event) async {
      chatAvailablity = event.docs[0].data()["ChatAvailablity"];
      if (!chatAvailablity) {
        setState(() {});
      }
    });
  }

  Future<void> addUserUidToFirebase() async {
    String uid =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.id;
    try {
      FirebaseFirestore fCF;
      await fCF.collection("Chats").doc(chatId).collection("ChatDetails").add({
        "UserUid": uid,
      });

      checkSetUserUid = true;
    } on SocketException catch (_) {
      checkSetUserUid = false;
    } catch (_) {
      checkSetUserUid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF638D8D),
        title: Text(
          "Online Customer Service",
          textScaleFactor: 1,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: addUserUidToFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: chatScreenBackground,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
          return Container(
            color: chatScreenBackground,
            child: Column(
              children: [
                Expanded(
                  child: ChatMessagesBlock(),
                ),
                chatAvailablity
                    ? InputFullCard()
                    : Text(
                        "You can't reply to this conversation anymore",
                        textScaleFactor: 1,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
