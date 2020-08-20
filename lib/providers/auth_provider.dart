import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Musicode/models/http_exception.dart';

// Instead of passing data through widget constructor arguments, which
// can then be forwarded to childrene widgets. This means that whenever we
// add a new widget inbetween we now have to pass the argument through that too.
// This can cause performacne issues too as the entire widget rebuild.
// A state is data that affects the UI and might  change over time.
// States can be app-wided data needed in multiple places in the app or widget (local) state text input
// etc.
// The provider package and pattern
// -We have a state/data provider that is attached to a widget. All the children
// of this widget can add a listener (of(context)) and establish a direct commnuiction to the data source
// The build mehtod of the widget that the listener is on will only rebuil this one widget not the whole tree.
// Whenever the data is updated in the provider the listener will rebuild the listening widget.
// Provider is also referred to as a model, but we are already using model to refer to our
// data classes or types. Such as an album.
// A mix in "with" keyword we merge some properties or methods into this class
// but are not extending (turning it inot a instance of a class)
// Change notifier is part of inherited widget, established behind the scenes communication tunnels
// AHhhh i think i get it: This will provide data to a consumer (widget that rely on the data)
// Any time this provider changes some data any of the listening widets will rebuild.
// the change notifier will yell out fire! the location will be found and the widgets will throw water on it (use the data)
// if new data is added we have to tell all the listeners that there is new data. There is a method to tell all the interested widgets
// change notifiers gives us access to a notifyListeners() method.
// To turn a class into a provider we need to provide the class provider at the highest possible point which is the MyApp of main for screens
// internal would be something closer. Essentially pick the highest point that makes sense.
// register a provider by wrapping widgets with a provider called ChangeNotifierProvider.
// this allows us to register a class as a provider for the childrene widgets that are listening.
// the builder takes the context and returns the provider. 3.0 otherwise use create w/ same context.

// Side not do not rebuild things that are unnecessary like a scaffold and appbar
// wrap those into a separate stateless widget and the internals can go into a statful widget

// Listen with Provider.of<provider type>(context) (sets up a back communication) in build method.
// The listener finds the Provider by moving up the tree until it finds a regsiterd provider.
// This will provide and instance of the provider class. and then by using setters and getters we can modify
// and retrieve data.

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
}
