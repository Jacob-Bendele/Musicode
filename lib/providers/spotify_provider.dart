import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Musicode/models/http_exception.dart';
import 'package:Musicode/models/album.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Spotify with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  static const String secret =
      "7af89624f3f84410a844e97138426bb5:5ce133421b494c1eb1723574a2b19796";

  set token(String spotifyToken) {
    _token = spotifyToken;
  }

  get token {
    return _token;
  }

  Future<void> authenitcate() async {
    final url = "https://accounts.spotify.com/api/token";
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic ' + (base64Encode(utf8.encode("${secret}")))
        },
        body: {
          'grant_type': 'client_credentials',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]);
      }

      _token = responseData['access_token'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: responseData['expires_in'],
        ),
      );
      print("the spotifyh token is $_token");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<Album> search(String albumTitle, String upc) async {
    final url =
        "https://api.spotify.com/v1/search?q=album:${albumTitle}&type=album";
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': "Bearer $_token"},
      );
      //check fo null idiot
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      } else if (responseData["albums"]["total"] == 0) {
        throw ("Album could not be found!");
      }

      final newAlbum = Album(
          upc: upc,
          title: responseData["albums"]["items"][0]["name"],
          artist: responseData["albums"]["items"][0]["artists"][0]["name"],
          imageUrl: responseData["albums"]["items"][0]["images"][1]["url"],
          id: '',
          spotifyUri: responseData["albums"]["items"][0]["uri"],
          appleUri: '');

      return newAlbum;
    } catch (error) {
      throw error;
    }
  }
}
