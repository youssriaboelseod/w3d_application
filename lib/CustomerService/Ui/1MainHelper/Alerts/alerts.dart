import 'package:flutter/material.dart';

void showAlert({BuildContext context, String message}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            message,
            textScaleFactor: 1,
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Okay",
                textScaleFactor: 1,
              ),
            ),
          ],
        );
      });
}
