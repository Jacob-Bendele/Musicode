import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Musicode/screens/albums_overview_screen.dart';
import 'package:Musicode/screens/authentication_screen.dart';
import 'package:Musicode/screens/splash_screen.dart';
import 'package:Musicode/screens/album_screen.dart';
import 'package:Musicode/providers/auth_provider.dart';
import 'package:Musicode/providers/album_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Albums>(
          update: (context, auth, prevAlbums) => Albums(auth.token, auth.userId,
              prevAlbums == null ? [] : prevAlbums.albums, auth.spotify),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // Trys to automatically login before taking to authscreen
            home: auth.isAuth
                ? AlbumsOverview()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            // Named routes of app screens
            routes: {
              '/login': (ctx) => AuthScreen(),
              '/album': (ctx) => AlbumScreen(),
              '/albums': (ctx) => AlbumsOverview(),
              '/splash': (ctx) => SplashScreen()
            }),
      ),
    );
  }
}
