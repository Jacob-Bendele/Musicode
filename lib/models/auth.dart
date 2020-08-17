import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Auth {
  String _toke;
  String _expire;
  String _uid;

  Future<void> signup(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]";
    http
        .post(url,
            body: json.encode(
              {
                'email': email,
                'password': password,
                'returnSecureToken': true,
              },
            ))
        .then((response) {
      print(response);
    });
  }
}
