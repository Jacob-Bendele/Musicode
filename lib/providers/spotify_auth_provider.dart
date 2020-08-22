import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Musicode/models/http_exception.dart';

class SpotifyAuth with ChangeNotifier {
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
      // _expiryDate = DateTime.now().add(
      //   Duration(
      //     seconds: int.parse(
      //       responseData['expires_in'],
      //     ),
      //   ),
      // );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
