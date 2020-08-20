import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Musicode/providers/album_provider.dart';
import 'package:Musicode/models/album.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Text(
                  "Hello!",
                )),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
              ),
              ListTile(title: Text("Logout"), onTap: () {}),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Musicode"),
      ),
      body: HistoryEntries(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/camera");
        },
        child: Icon(
          Icons.view_week,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class HistoryEntries extends StatefulWidget {
  @override
  _HistoryEntriesState createState() => _HistoryEntriesState();
}

class _HistoryEntriesState extends State<HistoryEntries> {
  @override
  Widget build(BuildContext context) {
    final albumData = Provider.of<Albums>(context);
    final albums = albumData.albums;
    return ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, i) {
          final album = Album(
            upc: albums[i].upc,
            title: albums[i].title,
            artist: albums[i].artist,
            imageUrl: albums[i].imageUrl,
          );
          return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                  ),
                ),
              ),
              height: 100,
              child: Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Image(
                    image: NetworkImage(albums[i].imageUrl),
                  ),
                ),
              ]));
        });
  }
}
