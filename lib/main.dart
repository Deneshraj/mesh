import 'package:flutter/material.dart';
import 'package:mesh/screens/auth/login_screen.dart';
import 'package:mesh/screens/landing/landing_screen.dart';

import 'theme.dart';

void main() {
  runApp(Mesh());
}

class Mesh extends StatefulWidget {
  @override
  _MeshState createState() => _MeshState();
}

class _MeshState extends State<Mesh> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mesh",
      darkTheme: darkThemeData(context),
      theme: lightThemeData(context),
      themeMode: ThemeMode.dark,
      routes: {
        LandingScreen.routeName: (context) => LandingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      initialRoute: LandingScreen.routeName,
    );
  }
}