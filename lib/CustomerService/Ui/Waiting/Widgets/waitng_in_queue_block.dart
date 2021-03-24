import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../Chat/Screen/chat_screen.dart';
import '../../../widgets/loading_block.dart';
import '../../../widgets/refresh_block.dart';

// ignore: must_be_immutable
class WaitingInQueueBlock extends StatelessWidget {
  int userNumber;
  int counter = 1;
  Timestamp dateStamp;
  DateTime dateTemp;

  int yourNumberInQueue(List documents, DateTime registerDate) {
    counter = 0;
    documents.forEach((element) {
      if (element.id != "InitialDocument") {
        dateStamp = element.data()["RegisterDate"];
        dateTemp = DateTime.parse(dateStamp.toDate().toString());
        if (dateTemp.isBefore(registerDate) || dateTemp == registerDate) {
          counter += 1;
        }
      }
    });
    print(counter);
    // counter - 1 to remove the number of the initial document
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime registerDate =
        Provider.of<UserProvider>(context, listen: false).registerDate;
    // ignore: deprecated_member_use
    Stream streamFirebase = Firestore.instance
        .collection("QueueOfClients")
        .doc("MainDocument")
        .collection("WaitingQueue")
        .snapshots();

    return StreamBuilder(

        // ignore: deprecated_member_use
        stream: streamFirebase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingBlock();
          }
          if (!snapshot.hasData) {
            return Container();
          }
          if (snapshot.hasError) {
            return RefreshBlock(null);
          }

          userNumber = yourNumberInQueue(snapshot.data.documents, registerDate);
          if (userNumber == 0) {
            // This future delay to fix unkown error
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushReplacementNamed(ChatScreen.routeName);
            });
          }
          print("rebuild stram 0000");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your number in queue :",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Color(0xFF364F8A),
                    child: Text(
                      userNumber.toString(),
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
