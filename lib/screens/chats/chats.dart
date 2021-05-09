import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh/constants.dart';
import 'package:mesh/models/toggle_theme.dart';
import 'package:mesh/screens/chats/components/chat_screen.dart';
import 'package:mesh/screens/chats/components/settings_screen.dart';
import 'package:mesh/utils/functions.dart';
import 'package:mesh/utils/requests.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsScreen extends StatefulWidget {
  static const routeName = "ChatsScreen";
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 0;
  List friends = [];

  _logout() async {
    String token = await getToken();
    if (token.isNotEmpty) {
      var response = await put(
        Uri.parse("$url/api/auth/logout"),
        token,
        'logout',
      );
      var body = jsonDecode(response.body);
      if (body['logged_out'] == true) {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        await _prefs.remove('auth_token');
      }
    }
  }

  _isLoggedIn() async {
    String token = await getToken();
    if (token.isNotEmpty) {
      var response = await getReq(
        Uri.parse("$url/api/auth/check_auth"),
        token,
      );

      var body = jsonDecode(response.body);

      if (body['auth'] == false || body['msg'] == "Unauthorized Request!") {
        _logout();
      }
    } else
      _logout();
  }

  @override
  Widget build(BuildContext context) {
    _isLoggedIn();

    ToggleTheme theme = Provider.of(context);
    var switchTheme = () {
      theme.toggleTheme();
    };

    List<Widget> _widgetList = [
      Chats(),
      Settings(),
    ];

    ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mesh',
          style: GoogleFonts.nunito(
            textStyle: _theme.textTheme.headline5,
            fontWeight: FontWeight.w900,
            color: _theme.appBarTheme.textTheme.headline5.color,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.search),
          SizedBox(width: 20),
        ],
      ),
      body: (_selectedIndex <= _widgetList.length)
          ? _widgetList[_selectedIndex]
          : _widgetList[0],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int num) {
          setState(() {
            _selectedIndex = num;
          });
          switch (num) {
            case 0:
              break;
            case 1:
              print("Settings");
              break;
            case 2:
              _logout();
              break;
            case 3:
              switchTheme();
              break;
            default:
              print("Invalid Option");
              break;
          }
        },
        currentIndex: _selectedIndex,
        selectedFontSize: 12.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: (_selectedIndex == 0) ? Icon(Icons.chat_bubble) : Icon(Icons.chat_bubble_outline),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.login_outlined), label: "Logout"),
          BottomNavigationBarItem(
            icon: (theme.light)
                ? Icon(Icons.lightbulb)
                : Icon(Icons.lightbulb_outline),
            label: (theme.light) ? "Light Mode" : "Dark Mode",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.person_add_alt_1,
        ),
        onPressed: () {
          print("Getting New Contact");
        },
      ),
    );
  }
}
