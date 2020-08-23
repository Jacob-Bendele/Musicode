import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Musicode/providers/album_provider.dart';
import 'package:Musicode/models/album.dart';
import 'package:Musicode/screens/camera_screen.dart';
import 'package:Musicode/providers/auth_provider.dart';

class AlbumsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void barcodeScanner() async {
      final scanner = new CameraScreen();
      await scanner.scanBarcodeNormal();
      if (scanner.barcode != null || scanner.barcode != "") {
        Provider.of<Albums>(context, listen: false).searchUpc(scanner.barcode);
        print(scanner.barcode);
      }
    }

    return Scaffold(
      drawer: SafeArea(
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
      ),
      appBar: AppBar(
        title: const Text("Musicode"),
      ),
      body: Entries(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          barcodeScanner();
        },
        icon: Icon(
          Icons.camera_alt,
        ),
        backgroundColor: Colors.blue,
        label: Text("Scan Barcode"),
      ),
    );
  }
}

class Entries extends StatefulWidget {
  @override
  _EntriesState createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  @override
  Widget build(BuildContext context) {
    final albumData = Provider.of<Albums>(context);
    final albums = albumData.albums;
    return ListView.separated(
        itemCount: albums.length,
        separatorBuilder: (context, i) => Divider(),
        itemBuilder: (context, i) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 100,
                            minWidth: 100,
                            maxHeight: 150,
                            maxWidth: 150),
                        child: Image(image: NetworkImage(albums[i].imageUrl))),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(albums[i].title, style: TextStyle(fontSize: 20)),
                        Text(albums[i].artist, style: TextStyle(fontSize: 10))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                  child: ListTile(
                                title: Text("Delete", style: TextStyle()),
                                onTap: () {},
                              )),
                            ]),
                  ),
                ],
              ));
        });
  }
}
