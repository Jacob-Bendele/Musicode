import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Musicode/providers/auth_provider.dart';
import 'package:Musicode/models/http_exception.dart';

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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                "Whoops!",
                textAlign: TextAlign.center,
              ),
              content: Text(
                message,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ));
  }

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

  bool _emailValidator(String email) {
    if (email.isEmpty || !email.contains('@')) {
      print("Invalid Email");
      _authData["email"] = "";
      print(_authData["email"]);
      const errorMessage = "This is not a valid email address.";
      _showErrorDialog(errorMessage);
      return false;
    }
    _authData["email"] = email;
    print("Valid Email");
    print(_authData["email"]);
    return true;
  }

  bool _passwordValidator(String password, [String confirmPassword]) {
    if ((_authMode == AuthMode.Login) &&
        (password.isEmpty || password.length < 6)) {
      print("The password is to short! to login $_authMode");
      const errorMessage = "Invalid password.";
      _showErrorDialog(errorMessage);

      return false;
    } else if (confirmPassword != null && confirmPassword.isNotEmpty) {
      if (password.isEmpty || password.length < 6) {
        print("The password is to short!");
        const errorMessage =
            "This password is too short. Please use at least 6 characters.";
        _showErrorDialog(errorMessage);
        return false;
      } else if (password != confirmPassword) {
        print("Passwords do not match!");
        const errorMessage = "The passwords do not match.";
        _showErrorDialog(errorMessage);
        return false;
      }
    }

    _authData["password"] = password;
    return true;
  }

  Future<void> _submit() async {
    bool pass = _passwordValidator(
        _passwordController.text, _confirmPasswordController.text);

    bool email = _emailValidator(_emailController.text);

    setState(() {
      _isLoading = true;
    });
    try {
      if (pass && email) {
        (_authMode == AuthMode.Login)
            ? await Provider.of<Auth>(context, listen: false)
                .login(_authData["email"], _authData["password"])
            : await Provider.of<Auth>(context, listen: false)
                .signup(_authData["email"], _authData["password"]);
      }
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
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
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
              colors: [Color(0xff318fb5), Color(0xff005086)])),
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
                                fontFamily: "OleoScript",
                                fontSize: 50,
                                color: Color(0xff005086)),
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
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
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
