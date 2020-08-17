import 'package:http/http.dart' as http;
import 'dart:convert';

class Album {
  final String name = "Pablo Honey";
  final String author = "Radiohead";
  final String imageUrl = "";
  final int prodDate = 1998;
  bool favorited = true;

  Album();

  static void addAlbum() {
    const url = "https://musicode-226a2.firebaseio.com/albums.json";
    http
        .post(url,
            body: json.encode({
              'title': name,
              'author': author,
              'imageUrl': null,
              'prodDate': 1998
            }))
        .then((response) {
      // the .then is thhe futur response from the http module.
      // the .then is ggoing to allow us to wait on this request.
      // async code is code that runs without stopping other code.
      // can create our own futur for async programming. Dart
      // will continue past a future waiting on the ..then().
      // Very similar to interrupts in embedded programmingg
      // the http package has meethods that return futures! that is
      // why this beehaviour is the way it is.
      // .then returns a new futur meaning .then can follow it again. This is called chaining.
      // can use .catchErrorr if the future fails. Can call ..then after catccherror.
      // Mediaquery will give you device sizes in the material package in flutter.
    }); // responsee is ggiven to funcion
  }
}
