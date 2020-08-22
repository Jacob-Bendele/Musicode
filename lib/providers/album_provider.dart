import 'package:flutter/material.dart';
import 'package:Musicode/models/Album.dart';
import 'package:Musicode/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Albums with ChangeNotifier {
  String authToken;
  String userId;
  String spotifyAuthToken =
      "BQCaLVD0dyGDaQQl1xq52G1TSYpSrdqF57rY_Vy1cK4D4CdIhPZusZxK19UN3bA1SUdvfiDReeRgplfZZ3k";

  List<Album> _albums = [
    Album(
      upc: '',
      title: 'OK computer',
      artist: 'radiohead',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Album(
      upc: '',
      title: 'In Raingbows',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
    Album(
      upc: '',
      title: 'Kid A',
      artist: 'radiohead',
      imageUrl:
          'https://i5.walmartimages.com/asr/cd193f07-fc44-4b60-8212-66bbd4b07817_1.c6a64e750652eb2ee68a72015d175c9f.jpeg?odnHeight=450&odnWidth=450&odnBg=ffffff',
    ),
  ];

  List<Album> get albums {
    return [..._albums];
  }

  void fetchAlbums() {}

  Future<void> searchUpc(String upc) async {
    final url = "https://itunes.apple.com/lookup?upc=${upc}";

    try {
      final response = await http.get(
        url,
      );
      print(json.decode(response.body));
    } catch (error) {
      print(error);
    }
  }

  // Future<void> addAlbum(String upc) async {
  //   final url =
  //       'https://flutter-update.firebaseio.com/albums.json?auth=$authToken';
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'title': product.title,
  //         'description': product.description,
  //         'imageUrl': product.imageUrl,
  //         'price': product.price,
  //         'creatorId': userId,
  //       }),
  //     );
  //     final newAlbum = Album(upc: '', title: '', artist: "", imageUrl: "");
  //     _albums.add(newAlbum);
  //     // _items.insert(0, newProduct); // at the start of the list
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  void deleteAlbum() {}
}
