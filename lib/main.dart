import 'package:Musicode/screens/favorites_screen.dart';
import 'package:Musicode/screens/authentication_screen.dart';
import 'package:Musicode/screens/camera_screen.dart';
import 'package:Musicode/screens/album_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthScreen(),

        // These are named routes and we can pass them parameters when we call them with tha navigator. Their is an arguments section.
        routes: {
          '/login': (ctx) => AuthScreen(),
          '/camera': (ctx) => CameraScreen(),
          '/album': (ctx) => AlbumScreen(),
          '/favorites': (ctx) => FavoritesScreen()
        });
  }
}
