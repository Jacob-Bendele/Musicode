import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Musicode/providers/album_provider.dart';
import 'package:Musicode/models/album.dart';
import 'package:Musicode/widgets/dialog_widget.dart';

// The widget that defines the tiles that are displayed in the album overview screen
class AlbumListTile extends StatelessWidget {
  const AlbumListTile({
    Key key,
    @required this.albums,
    @required this.index,
  }) : super(key: key);

  final List<Album> albums;
  final int index;

  @override
  Widget build(BuildContext context) {
    // Adds the onTap functionality to album tile widget
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/album", arguments: {"index": index});
      },
      child: Container(
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
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 100,
                            minWidth: 100,
                            maxHeight: 150,
                            maxWidth: 150),
                        child:
                            Image(image: NetworkImage(albums[index].imageUrl))),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(albums[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(albums[index].artist,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12)),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            // The delete tile in the popup menu for each ablum tile
                            child: ListTile(
                              title: Text("Delete", style: TextStyle()),
                              onTap: () {
                                // Trys to delete the album from the database
                                // Pops the popup menu from the screen
                                final id = albums[index].id;
                                try {
                                  Provider.of<Albums>(context, listen: false)
                                      .deleteAlbum(id);
                                  Navigator.of(context).pop();
                                } catch (error) {
                                  dialog(
                                      "There was a problem deleting this album. Please try again later.",
                                      "error",
                                      context);
                                }
                              },
                            ),
                          ),
                        ]),
              ),
            ],
          )),
    );
  }
}
