import 'package:flutter/material.dart';

void showErrorDialog(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(
              "Whoops!",
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
