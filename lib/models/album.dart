import 'package:flutter/material.dart';

class Album {
  final String upc;
  final String title;
  final String artist;
  final String imageUrl;
  final String id;
  final String spotifyUri;
  final String appleUri;

  Album(
      {@required this.upc,
      @required this.title,
      @required this.artist,
      @required this.imageUrl,
      @required this.id,
      @required this.spotifyUri,
      @required this.appleUri});

//   static void addAlbum() {
//     const url = "https://musicode-226a2.firebaseio.com/albums.json";
//     http
//         .post(url,
//             body: json.encode({
//               'title': name,
//               'author': author,
//               'imageUrl': null,
//               'prodDate': 1998
//             }))
//         .then((response) {
//       // the .then is thhe futur response from the http module.
//       // the .then is ggoing to allow us to wait on this request.
//       // async code is code that runs without stopping other code.
//       // can create our own futur for async programming. Dart
//       // will continue past a future waiting on the ..then().
//       // Very similar to interrupts in embedded programmingg
//       // the http package has meethods that return futures! that is
//       // why this beehaviour is the way it is.
//       // .then returns a new futur meaning .then can follow it again. This is called chaining.
//       // can use .catchErrorr if the future fails. Can call ..then after catccherror.
//       // Mediaquery will give you device sizes in the material package in flutter.
//     }); // responsee is ggiven to funcion
//   }
}
