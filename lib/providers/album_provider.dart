import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Musicode/models/Album.dart';
import 'package:Musicode/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:Musicode/providers/spotify_provider.dart';

class Albums with ChangeNotifier {
  String _authToken;
  String _userId;
  List<Album> _albums = [];

  Albums(this._authToken, this._userId, this._albums);

  List<Album> get albums {
    return [..._albums];
  }

  void fetchAlbums() {
    final url =
        "https://musicode-226a2.firebaseio.com/albums.json?auth=${_authToken}&orderBy=creatorId&equalTo=${_userId}";
  }

  void processBarcode(upc) async {
    //search upc
    // find on spotify return album
    // find on apple music ??
    // add album to db
    // Notify to update UI
  }

  List<String> processSearchResponse(responseData) {
    String title = responseData["items"][0]["title"];
    List<String> list;
    if (title.contains("(") || title.contains(")")) {
      final index = title.indexOf("(");
      title = title.substring(0, index);
    }

    if (title.contains("[") || title.contains("]")) {
      final index = title.indexOf("[");
      title = title.substring(0, index);
    }

    if (title.contains("-")) {
      list = title.split("-");
      print(list);
    }
    return list;
  }

  Future<void> searchUpc(String upc) async {
    //final url = "https://itunes.apple.com/lookup?upc=${upc}";

    final url = "https://api.upcitemdb.com/prod/trial/lookup?upc=${upc}";

    try {
      final response = await http.get(url);

      final responseData = json.decode(response.body);

      if (responseData["code"] != null) {
        throw HttpException(responseData["message"]);
      }

      print(responseData);
      // } else if (extractedData["resultCount"] == 0) {
      //   final error = "Could not find UPC.";
      //   throw error;
      // }

      // final newAlbum = Album(
      //     upc: upc,
      //     title: extractedData["results"][0]["collectionName"],
      //     artist: extractedData["results"][0]["artistName"],
      //     imageUrl: extractedData["results"][0]["artworkUrl100"],
      //     id: '',
      //     spotifyUri: '',
      //     appleUri: '');

      List<String> list = processSearchResponse(responseData);

      Spotify spot = new Spotify();
      await spot.authenitcate();
      spot.search(list[1]);
      // final newAlbum = Album(
      //     upc: upc,
      //     title: extractedData["results"][0]["collectionName"],
      //     artist: extractedData["results"][0]["artistName"],
      //     imageUrl: extractedData["results"][0]["artworkUrl100"],
      //     id: '',
      //     spotifyUri: '',
      //     appleUri: '');
      // //searchSpotify(newAlbum)
      // //searchApple(newAlbumn)
      // addAlbum(newAlbum);
      //TODO: extract data send to add album
      // error hadnling for no repsonse
      // pust error dialog into models folder

    } catch (error) {
      throw error;
    }
  }

  Future<void> addAlbum(Album album) async {
    final url =
        'https://musicode-226a2.firebaseio.com/albums.json?auth=$_authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'upc': album.upc,
          'title': album.title,
          'artist': album.artist,
          'imageUrl': album.imageUrl,
          'creatorId': _userId,
        }),
      );

      final newAlbum = Album(
          upc: album.upc,
          title: album.title,
          artist: album.artist,
          imageUrl: album.imageUrl,
          id: json.decode(response.body)["name"]);

      _albums.insert(0, newAlbum);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void deleteAlbum() {}
}
