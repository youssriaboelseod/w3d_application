import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers/alert_function.dart';
import '../../../providers/upload_message_provider.dart';

class InputFullCard extends StatelessWidget {
  final userInputController = TextEditingController();

  Future<void> submitOfflineMessage(
    BuildContext context,
    String message,
  ) async {
    DateTime sendDate = DateTime.now();

    String checkSend =
        await Provider.of<UploadMessageProvider>(context, listen: false)
            .uploadMessage(message, sendDate);
    if (checkSend != null) {
      alert(context, checkSend);
      return;
    }
    userInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 2,
            ),
            child: IconButton(
              icon: Icon(
                Icons.attach_file,
                size: 25,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: userInputController,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Write your message!",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    helperMaxLines: 4,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 12,
                      top: 8,
                      bottom: 8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 5,
            ),
            child: CircleAvatar(
              backgroundColor: Color(0xFF547B7B),
              child: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  String userInput = userInputController.text.trim();
                  if (userInput.isEmpty) {
                    return;
                  } else {
                    submitOfflineMessage(context, userInput);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
