import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Musicode/models/album.dart';
import 'package:Musicode/models/http_exception.dart';
import 'package:Musicode/providers/spotify_provider.dart';

class Albums with ChangeNotifier {
  String _authToken;
  String _userId;
  List<Album> _albums;
  Spotify spotify;

  Albums(this._authToken, this._userId, this._albums, this.spotify);

  List<Album> get albums {
    return [..._albums];
  }

  // Called upon logout to clear the album list
  void cleanUp() {
    _albums = new List<Album>();
  }

  // Process barcode by searching for upc, serching spotify, and then adding the album
  Future<void> processBarcode(String upc) async {
    try {
      String albumTitle = await searchUpc(upc);
      final Album returnedAlbum = await spotify.search(albumTitle, upc);
      await addAlbum(returnedAlbum);
    } catch (error) {
      throw error;
    }
  }

  // Processes the search response based on common response formats from UPC database API
  String processSearchResponse(responseData) {
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
      title = list[1];
    }
    return title;
  }

  // Fetches the user's ablums from Firebase database
  Future<void> fetchAlbums() async {
    final url =
        'https://musicode-226a2.firebaseio.com/albums.json?auth=$_authToken&orderBy="creatorId"&equalTo="$_userId"';

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData["error"] != null)
        throw HttpException(responseData["error"]);

      extractedData.forEach((albumId, albumData) {
        _albums.add(Album(
            id: albumId,
            upc: albumData["upc"],
            title: albumData["title"],
            artist: albumData["artist"],
            imageUrl: albumData["imageUrl"],
            spotifyUri: albumData["spotifyUri"],
            appleUri: albumData["appleUri"]));
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Sends search to UPC database API
  // Calls on processSearchResponse to get a useful search string for Spotify
  Future<String> searchUpc(String upc) async {
    final url = "https://api.upcitemdb.com/prod/trial/lookup?upc=$upc";

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (responseData["message"] != null) {
        throw HttpException(responseData["message"]);
      }

      String albumTitle = processSearchResponse(responseData);
      return albumTitle;
    } catch (error) {
      throw error;
    }
  }

  // Add an album to the Firebase database following the album model
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
          'spotifyUri': album.spotifyUri,
          'appleUri': album.appleUri,
          'creatorId': _userId,
        }),
      );

      final newAlbum = Album(
          upc: album.upc,
          title: album.title,
          artist: album.artist,
          imageUrl: album.imageUrl,
          spotifyUri: album.spotifyUri,
          appleUri: album.appleUri,
          id: json.decode(response.body)["name"]);

      _albums.insert(0, newAlbum);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Delete album from Firebase database
  Future<void> deleteAlbum(String id) async {
    final url =
        'https://musicode-226a2.firebaseio.com/albums/$id.json?auth=$_authToken';

    final existingAlbumIndex = _albums.indexWhere((album) => album.id == id);
    var existingAlbum = _albums[existingAlbumIndex];
    _albums.removeAt(existingAlbumIndex);
    notifyListeners();
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _albums.insert(existingAlbumIndex, existingAlbum);
        notifyListeners();
        throw HttpException("Could not delete album.");
      }

      existingAlbum = null;
    } catch (error) {
      throw error;
    }
  }
}
