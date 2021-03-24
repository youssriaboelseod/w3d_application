import 'package:flutter/material.dart';

void alert(BuildContext context, String alertMessage) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            content: Text(
              alertMessage,
              textScaleFactor: 1,
            ),
            title: Text(
              "Warning!",
              textScaleFactor: 1,
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  textScaleFactor: 1,
                ),
              ),
            ],
          ));
}
