import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:Musicode/providers/album_provider.dart';
import 'package:Musicode/widgets/dialog_widget.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    // Platform independnt method for launching URLs
    Future<void> _launchUrl(url) async {
      try {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      } catch (error) {
        throw error;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Musicode",
          style: TextStyle(
              fontFamily: "OleoScript", fontSize: 25, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            // Boxshadow for the Album art box
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
              // Album art
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 400,
                    maxWidth: 400,
                    minHeight: 150,
                    minWidth: 150),
                child: Image(
                    fit: BoxFit.fill,
                    // Gets the imageUrl from the selected album
                    image: NetworkImage(Provider.of<Albums>(context)
                        .albums[arguments["index"]]
                        .imageUrl)),
              ),
            ),
          ),
          // Album title text
          Text(Provider.of<Albums>(context).albums[arguments["index"]].title,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          // Album artist text
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
            child: Text(
                Provider.of<Albums>(context).albums[arguments["index"]].artist,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12)),
          ),
          // Spotify button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                child: RaisedButton(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image(
                        image: AssetImage("assets/images/spotifyLogo.png")),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () async {
                    // Gets the save Spotify URI and sends it to the launcher helper method
                    final url = Uri.encodeFull(Provider.of<Albums>(context)
                        .albums[arguments["index"]]
                        .spotifyUri);
                    try {
                      await _launchUrl(url);
                    } catch (error) {
                      dialog("Install Spotify for full functionality.", "error",
                          context);
                    }
                  },
                )),
          ),
        ]),
      ),
    );
  }
}
