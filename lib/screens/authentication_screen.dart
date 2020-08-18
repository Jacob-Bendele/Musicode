import 'package:flutter/material.dart';
import 'package:Musicode/models/auth.dart';

enum AuthMode { Login, Signup }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.Login;
  var _valid = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  bool _emailValidator(String email) {
    if (email.isEmpty || !email.contains('@')) {
      print("Invalid Email");
      _authData["email"] = "";
      print(_authData["email"]);
      return false;
    }
    _authData["email"] = email;
    print("Valid Email");
    print(_authData["email"]);
    return true;
  }

  bool _passwordValidator(String password, [String confirmPassword]) {
    if (confirmPassword == null) {
      if (password.isEmpty || password.length < 5) {
        print("The password is to short!");
        return false;
      }

      _authData["password"] = password;
      return true;
    } else if (confirmPassword != null) {
      if (password.isEmpty || password.length < 5) {
        print("The password is to short!");
        return false;
      } else if (password != confirmPassword) {
        print("Passwords do not match!");
        return false;
      }

      _authData["password"] = password;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              // White box around entry area
              child: Container(
                  height: (_authMode == AuthMode.Login)
                      ? size.height * 0.55
                      : size.height * 0.60,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 25.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // App title field
                          Text(
                            "Musicode",
                            style: TextStyle(
                                fontFamily: "OleoScript", fontSize: 50),
                          ),
                          SizedBox(height: 20),
                          // Email Input Field
                          TextField(
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                          ),
                          // Adds a blank box as space, more readable generally than padding.
                          SizedBox(height: 10),
                          // Password Field
                          TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                          ),
                          SizedBox(height: 10),
                          // Confirm Password Field
                          if (_authMode == AuthMode.Signup)
                            TextField(
                              obscureText: true,
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Icon(
                                    Icons.check,
                                    color: Colors.black,
                                  ),
                                  hintText: "Confirm Password",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                            ),
                          if (_authMode == AuthMode.Signup)
                            SizedBox(height: 10),
                          // Login and Signup Button
                          Container(
                              width: double.infinity,
                              child: RaisedButton(
                                color: Colors.lightBlue,
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  bool pass = _passwordValidator(
                                      _passwordController.text,
                                      _confirmPasswordController.text);

                                  bool email =
                                      _emailValidator(_emailController.text);

                                  if (pass && email) {
                                    (_authMode == AuthMode.Signup)
                                        ? Auth.signup(_authData["email"],
                                            _authData["password"])
                                        : null;
                                  }
                                },
                                child: Text(
                                  _authMode == AuthMode.Login
                                      ? "Login"
                                      : "Signup",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // Signup Login Button
                              Container(
                                  child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _switchAuthMode();
                                  });
                                },
                                textColor: Colors.black,
                                child: Text(_authMode == AuthMode.Login
                                    ? "Sign Up"
                                    : "Login"),
                              )),
                              // Forgot Password Button
                              Container(
                                  child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {},
                                textColor: Colors.black,
                                child: Text("Forgot Password?"),
                              )),
                            ],
                          ),
                        ]),
                  )))),
    );
  }
}
