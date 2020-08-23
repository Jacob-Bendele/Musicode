import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Musicode/models/http_exception.dart';
import 'package:Musicode/models/album.dart';

class Spotify with ChangeNotifier {
  String _token;
  DateTime _expireyDate;
  static const String secret = "";

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
      _expireyDate = DateTime.now().add(
        Duration(
          seconds: responseData['expires_in'],
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<Album> search(String albumTitle) async {
    final url =
        "https://api.spotify.com/v1/search?q=album:${albumTitle}&type=album";
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': "Bearer ${_token}"},
      );
      //check fo null idiot
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["messag"]);
      } else if (responseData["albums"]["total"] == 0) {
        throw ("Album could not be found!");
      }

      print(responseData["albums"]["items"][0]["name"]);
    } catch (error) {
      throw error;
    }
  }
}
