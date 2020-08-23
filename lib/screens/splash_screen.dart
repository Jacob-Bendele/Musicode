import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff318fb5), Color(0xff005086)])),
      ),
    );
  }
}
