import 'package:flutter/material.dart';
import 'package:Musicode/models/Album.dart';

class Albums with ChangeNotifier {
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

    void addAlbum() {
      notifyListeners();
    }
  }
}
