import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Musicode/providers/album_provider.dart';
import 'package:Musicode/screens/camera_screen.dart';
import 'package:Musicode/widgets/drawer_widget.dart';
import 'package:Musicode/widgets/dialog_widget.dart';
import 'package:Musicode/widgets/album_list_tile_widget.dart';

class AlbumsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Launches the camera scanner and sends the result barcode to
    // be processed. Pushes new screen for the scanned album.
    Future<void> barcodeScanner() async {
      final scanner = new CameraScreen();
      await scanner.scanBarcodeNormal();
      if ((scanner.barcode != null) || (scanner.barcode != "")) {
        try {
          await Provider.of<Albums>(context, listen: false)
              .processBarcode(scanner.barcode);
          // Magic number index 0 as the new album is appended to the first index in the list
          Navigator.pushNamed(context, "/album", arguments: {"index": 0});
        } catch (error) {
          dialog("Could not find this album.", "error", context);
        }
      }
    }

    // Static elements of the albums overview screen
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Musicode",
          style: TextStyle(
              fontFamily: "OleoScript", fontSize: 25, color: Colors.white),
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

  // Fetch the ablums for the user from the database
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

  // Builds the list view and album list tiles based on fetched data
  // Listens for the album provider to change the album list
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
              return AlbumListTile(albums: albums, index: i);
            });
  }
}
