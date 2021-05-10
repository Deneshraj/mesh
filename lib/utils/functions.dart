import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (_prefs.containsKey('auth_token')) {
    return _prefs.getString('auth_token');
  } else
    return "";
}

Future<bool> sendAuthorizedReq({ Function func }) async {
  String token = await getToken();

  if (token.isNotEmpty) {
    await func(token);
    return true;
  }

  return false;
}