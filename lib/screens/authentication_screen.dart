import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Musicode/providers/auth_provider.dart';
import 'package:Musicode/models/http_exception.dart';
import 'package:Musicode/widgets/dialog_widget.dart';

enum AuthMode { Login, Signup }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.Login;
  bool _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  // Text controller to handle the input text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Switches between login and signup to affect the auth widget
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _confirmPasswordController.clear();
      });
    }
  }

  // Validates email address
  bool _emailValidator(String email) {
    if (email.isEmpty || !email.contains('@')) {
      print("Invalid Email");
      _authData["email"] = "";
      print(_authData["email"]);
      const errorMessage = "This is not a valid email address.";
      dialog(errorMessage, "error", context);
      return false;
    }
    _authData["email"] = email;
    print("Valid Email");
    print(_authData["email"]);
    return true;
  }

  // Password validator checks for length and matching
  bool _passwordValidator(String password, [String confirmPassword]) {
    if ((_authMode == AuthMode.Login) &&
        (password.isEmpty || password.length < 6)) {
      print("The password is to short! to login $_authMode");
      const errorMessage = "Invalid password.";
      dialog(errorMessage, "error", context);
      return false;
    } else if (confirmPassword != null && confirmPassword.isNotEmpty) {
      if (password.isEmpty || password.length < 6) {
        print("The password is to short!");
        const errorMessage =
            "This password is too short. Please use at least 6 characters.";
        dialog(errorMessage, "error", context);
        return false;
      } else if (password != confirmPassword) {
        print("Passwords do not match!");
        const errorMessage = "The passwords do not match.";
        dialog(errorMessage, "error", context);
        return false;
      }
    }

    _authData["password"] = password;
    return true;
  }

  // Reset password via the Firebase authentication
  Future<void> resetPassword() async {
    bool email = _emailValidator(_emailController.text);
    try {
      if (email) {
        await Provider.of<Auth>(context, listen: false)
            .resetPassword(_emailController.text);
        dialog("Password reset email sent!", "notice", context);
      } else {
        throw ("Please enter an email before resetting password.");
      }
    } catch (error) {
      dialog(error, "error", context);
    }
  }

  // Submit the text filds for login or signup
  Future<void> _submit() async {
    bool pass = _passwordValidator(
        _passwordController.text, _confirmPasswordController.text);

    bool email = _emailValidator(_emailController.text);

    setState(() {
      _isLoading = true;
    });
    try {
      // Validate pass and email before trying login or signup
      if (pass && email) {
        (_authMode == AuthMode.Login)
            ? await Provider.of<Auth>(context, listen: false)
                .login(_authData["email"], _authData["password"])
            : await Provider.of<Auth>(context, listen: false)
                .signup(_authData["email"], _authData["password"]);
      }
      // Handles diagnostics TODO: make a separate diagnostic handler outside
      // of the screens
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      dialog(errorMessage, "error", context);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      dialog(errorMessage, "error", context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff2A628F), Color(0xff3E92CC)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              // White box around entry area
              child: Container(
                  // Logic for box height based on AuthMode
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
                                fontFamily: "OleoScript",
                                fontSize: 50,
                                color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          // Email input field
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
                          // Adds a blank box as space, more readable generally than padding
                          SizedBox(height: 10),
                          // Password input field
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
                          // Confirm password field
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
                          // Login and Signup button
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            // Submit the form for login or signup
                            Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  color: Colors.lightBlue,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  onPressed: () {
                                    _submit();
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
                              // Swith AuthModes between login and signup
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
                              // Forgot password button
                              Container(
                                  child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  resetPassword();
                                },
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
