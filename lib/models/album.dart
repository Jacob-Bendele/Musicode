import 'package:flutter/material.dart';

// Model for albums
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
}
