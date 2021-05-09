import 'package:flutter/foundation.dart';

class AuthToken with ChangeNotifier{
  String _token;

  String get token => _token;

  AuthToken(String token) {
    _token = token;
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}