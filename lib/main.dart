import 'package:Musicode/screens/albums_overview_screen.dart';
import 'package:Musicode/screens/authentication_screen.dart';
import 'package:Musicode/screens/splash_screen.dart';
import 'package:Musicode/screens/album_screen.dart';
import 'package:Musicode/providers/auth_provider.dart';
import 'package:Musicode/providers/album_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Albums>(
          update: (context, auth, prevAlbums) => Albums(auth.token, auth.userId,
              prevAlbums == null ? [] : prevAlbums.albums),
        ),
      ],
      // When auth provider uses notify change method this consumer acts hihgly
      // similar to that of Provider.of<>(). That is to say a consumer listens for
      // a state change. This will then call a rebuild on the material app allowing
      // control over what to be displayed first dependant on authorization.
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // we want to change this upon the user already being logged in
            //
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
            // home: AlbumsOverview(),

            // These are named routes and we can pass them parameters when we call them with tha navigator. Their is an arguments section.
            routes: {
              '/login': (ctx) => AuthScreen(),
              '/album': (ctx) => AlbumScreen(),
              '/favorites': (ctx) => AlbumsOverview(),
              '/splash': (ctx) => SplashScreen()
            }),
      ),
    );
  }
}
