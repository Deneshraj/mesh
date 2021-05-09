import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleTheme with ChangeNotifier {
  String _key = "theme";
  bool _light;
  SharedPreferences _prefs;
  
  bool get light => _light;

  ToggleTheme() {
    _light = true;
    _loadSharedPrefs();
  }

  getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

   toggleTheme() {
    _light = !_light;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if(_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadSharedPrefs() async {
    await _initPrefs();
    if(_prefs.containsKey(_key)) _light = _prefs.getBool(_key);
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(_key, _light);
  }
}