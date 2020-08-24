import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Musicode/providers/auth_provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.70,
        child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              // remove an put in separate widget
              child: Center(
                  child: Text(
                "Hello!",
              )),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () {
                  Navigator.of(context).pop(); // closes drawer
                  Provider.of<Auth>(context, listen: false).logout();
                }),
            Divider(),
          ]),
        ),
      ),
    );
  }
}
