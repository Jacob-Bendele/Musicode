import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The intermediate splashscreen for logout and autologin
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff2A628F), Color(0xff3E92CC)])),
      child: Center(
          child: Container(
              child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    "assets/images/logoWhite.png",
                  )))),
    ));
  }
}
