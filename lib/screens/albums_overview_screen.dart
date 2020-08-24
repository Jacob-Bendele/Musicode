import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Musicode/providers/album_provider.dart';
import 'package:Musicode/models/album.dart';
import 'package:Musicode/screens/camera_screen.dart';
import 'package:Musicode/providers/auth_provider.dart';
import 'package:Musicode/widgets/drawer_widget.dart';

class AlbumsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void barcodeScanner() async {
      final scanner = new CameraScreen();
      await scanner.scanBarcodeNormal();
      if (scanner.barcode != null || scanner.barcode != "") {
        Provider.of<Albums>(context, listen: false)
            .processBarcode(scanner.barcode);
        print(scanner.barcode);
      }
    }

    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Musicode",
          style: TextStyle(
              fontFamily: "OleoScript", fontSize: 20, color: Colors.black),
        ),
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
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Albums>(context).fetchAlbums().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final albumData = Provider.of<Albums>(context);
    final albums = albumData.albums;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemCount: albums.length,
            separatorBuilder: (context, i) => Divider(),
            itemBuilder: (context, i) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3))
                            ]),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: 100,
                                    minWidth: 100,
                                    maxHeight: 150,
                                    maxWidth: 150),
                                child: Image(
                                    image: NetworkImage(albums[i].imageUrl))),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(albums[i].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20)),
                            Text(albums[i].artist,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => <PopupMenuEntry>[
                                  PopupMenuItem(
                                      child: ListTile(
                                    title: Text("Delete", style: TextStyle()),
                                    onTap: () {
                                      final id = albums[i].id;
                                      Provider.of<Albums>(context,
                                              listen: false)
                                          .deleteAlbum(id);
                                      Navigator.of(context).pop();
                                    },
                                  )),
                                ]),
                      ),
                    ],
                  ));
            });
  }
}
