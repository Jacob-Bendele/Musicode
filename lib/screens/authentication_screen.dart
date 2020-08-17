import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final Widget emailField = TextField(
    obscureText: false,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final Widget passwordField = TextField(
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ));

  final Widget loginButton = Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.lightBlue,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {},
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ));

  final Widget signupButton = Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {},
        textColor: Colors.black,
        child: Text("Signup"),
      ));

  final Widget forgotPassword = Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {},
        textColor: Colors.black,
        child: Text("Forgot Password?"),
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Musicode",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 40),
                          ),
                          SizedBox(height: 20),
                          emailField,
                          // Adds a blank box as space, more readable generally than padding.
                          SizedBox(height: 10),
                          passwordField,
                          SizedBox(height: 10),
                          loginButton,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              signupButton,
                              forgotPassword,
                            ],
                          ),
                        ]),
                  )))),
    );
  }
}
