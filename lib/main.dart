import 'package:flutter/material.dart';
import 'package:mesh/models/auth_token.dart';
import 'package:mesh/models/toggle_theme.dart';
import 'package:mesh/screens/auth/login_screen.dart';
import 'package:mesh/screens/chats/chats.dart';
import 'package:mesh/screens/landing/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var authToken = _prefs.getString('auth_token') ?? "";

  runApp(Mesh(
    authToken: authToken,
  ));
}

class Mesh extends StatefulWidget {
  final String authToken;

  const Mesh({
    Key key,
    this.authToken,
  }) : super(key: key);
  @override
  _MeshState createState() => _MeshState();
}

class _MeshState extends State<Mesh> {
  @override
  Widget build(BuildContext context) {
    AuthToken _authToken = AuthToken(widget.authToken);
    ToggleTheme _theme = ToggleTheme();

    return MultiProvider(
      child: Consumer<ToggleTheme>(
        builder: (context, ToggleTheme notifier, child) {
          ThemeMode mode = ThemeMode.light;
          if(_theme != null) {
            mode = (_theme.light) ? ThemeMode.light : ThemeMode.dark;
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Mesh",
            darkTheme: darkThemeData(context),
            theme: lightThemeData(context),
            themeMode: mode,
            routes: {
              '/': (context) {
                if (_authToken.token.isNotEmpty) return ChatsScreen();
                return LandingScreen();
              },
              LandingScreen.routeName: (context) => LandingScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              ChatsScreen.routeName: (context) => ChatsScreen(),
            },
            initialRoute: '/',
          );
        },
      ),
      providers: [
        ChangeNotifierProvider<AuthToken>.value(
          value: _authToken,
        ),
        ChangeNotifierProvider<ToggleTheme>.value(
          value: _theme,
        ),
      ],
    );
  }
}
