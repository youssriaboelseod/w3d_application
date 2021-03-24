import 'package:flutter/material.dart';
import '../../../Ui/1MainHelper/Alerts/alerts.dart';
import '../../../Ui/Opps/Screen/opps_screen.dart';
import '../../../Ui/Waiting/Screen/waiting_screen.dart';
import 'package:provider/provider.dart';
import '../../../providers/upload_message_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../../Providers/AuthDataProvider/auth_data_provider.dart';

void showStartConversationAlert(
    {BuildContext context, String message, Function callSetState}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            message,
            textScaleFactor: 1,
          ),
          actions: [
            FlatButton(
              child: Text(
                "No",
                textScaleFactor: 1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Yes",
                textScaleFactor: 1,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await register(
                  context: context,
                  callSetState: callSetState,
                );
              },
            ),
          ],
        );
      });
}

Future<void> register({BuildContext context, Function callSetState}) async {
  bool checkRegister = false;

  String email =
      Provider.of<AuthDataProvider>(context, listen: false).currentUser.email;
  String password = Provider.of<AuthDataProvider>(context, listen: false)
      .currentUser
      .password;
  callSetState();
  Map out = await Provider.of<UserProvider>(context, listen: false)
      .registerInQueue(email: email, password: password);
  callSetState();

  checkRegister = out["State"];
  if (!checkRegister) {
    if (out["Output"] == "We aren't available right now") {
      Navigator.of(context).pushNamed(CustomerServiceOppsScreen.routeName);
    } else {
      showAlert(
        context: context,
        message: out["Output"],
      );
    }

    return;
  }
  String id = Provider.of<UserProvider>(context, listen: false).chatId;
  Provider.of<UploadMessageProvider>(context, listen: false).setChatId(id);
  Navigator.of(context).pushNamed(CustomerServiceWaitingScreen.routeName);
  return null;
}
