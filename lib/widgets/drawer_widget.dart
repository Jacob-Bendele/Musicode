import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:Musicode/providers/auth_provider.dart';
import 'package:Musicode/providers/album_provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Platform independent function for laucnhing URLs
    Future<void> _launchUrl(url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    // The drawer widget
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.70,
        child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            // Decorative drawer head
            DrawerHeader(
              child: Image(image: AssetImage("assets/images/logoWhite.png")),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // Logout tile in the drawer
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () {
                  // Pop the drawer off the screen, logout, and clear the list of albums
                  Navigator.of(context).pop();
                  Provider.of<Auth>(context, listen: false).logout();
                  Provider.of<Albums>(context, listen: false).cleanUp();
                }),
            Divider(),
            // About tile in the drawer will launch the URL to the github
            ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                onTap: () {
                  final url = "https://github.com/Jacob-Bendele/Musicode";
                  _launchUrl(url);
                }),
            Divider(),
          ]),
        ),
      ),
    );
  }
}
