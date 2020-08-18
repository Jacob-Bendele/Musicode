import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Auth {
  String _token;
  String _expire;
  String _uid;

  static Future<void> signup(String email, String password) async {
    const url =
<<<<<<< HEAD
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${AuthAPI}";
=======
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCqkIHLWZ6VCq3oWWhF7GtygOayr6_pCxs";
>>>>>>> 9b8e5d979ea3a90fa8a8d11d67426411fb0c1a85
    final response = await http.post(url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ));
    print(json.decode(response.body));
  }
}
