import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../models/message_details_model.dart';
import 'message_container.dart';
import '../../../widgets/refresh_block.dart';

// ignore: must_be_immutable
class ChatMessagesBlock extends StatelessWidget {
  Stream streamFirebase;

  List<MessageDetailsModel> chatMessages = [];

  void prepareFirebaseMessages(List<QueryDocumentSnapshot> messagesDocuments) {
    List<MessageDetailsModel> tempListMessages = [];
    Timestamp temp;
    messagesDocuments.forEach((element) {
      temp = element.data()["SendDate"];

      tempListMessages.add(
        MessageDetailsModel(
          sendDate: DateTime.parse(temp.toDate().toString()),
          meesage: element.data()["Message"],
          senderType: element.data()["SenderType"],
        ),
      );
    });
    chatMessages = tempListMessages;
  }

  @override
  Widget build(BuildContext context) {
    final String chatId =
        Provider.of<UserProvider>(context, listen: false).chatId;

    // ignore: deprecated_member_use
    streamFirebase = Firestore.instance
        .collection("Chats")
        .doc(chatId)
        .collection("ChatMessages")
        .orderBy("SendDate", descending: true)
        .snapshots();
    // descending تنازلي
    return StreamBuilder(
        // ignore: deprecated_member_use
        stream: streamFirebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (!snapshot.hasData) {
            return Container();
          }
          if (snapshot.hasError) {
            return RefreshBlock(null);
          }
          if (snapshot.data.documents.length != chatMessages.length) {
            prepareFirebaseMessages(snapshot.data.documents);
          }

          print("rebuild chat block 0000");
          return ListView.builder(
            reverse: true,
            itemCount: chatMessages.length,
            itemBuilder: (_, index) {
              if (chatMessages[index].senderType == "Client") {
                return RightSideMessage(chatMessages[index].meesage);
              } else {
                return LeftSideMessage(chatMessages[index].meesage);
              }
            },
          );
        });
  }
}
