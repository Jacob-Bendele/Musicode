import 'package:flutter/material.dart';

// A reusable dialog box that takes a message and string type
// The message will be displayed and the type will determine dialog type
void dialog(String message, String type, BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(
              (type == "error") ? "Whoops!" : "Notice",
              textAlign: TextAlign.center,
            ),
            content: Text(
              message,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ));
}
