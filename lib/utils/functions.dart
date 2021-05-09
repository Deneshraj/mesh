import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (_prefs.containsKey('auth_token')) {
    return _prefs.getString('auth_token');
  } else
    return "";
}
