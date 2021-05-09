import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh/screens/auth/components/bottom_row.dart';
import 'package:mesh/screens/auth/components/login_input.dart';
import 'package:mesh/screens/auth/components/password_input.dart';
import 'package:mesh/screens/chats/chats.dart';
import 'package:mesh/screens/components/rounded_button.dart';
import 'package:mesh/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "Login Screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _toggleLogin() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  bool _validateFields() {
    bool _isValid = true;
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackbar(context, "Please Enter valid Email and Password");
      _isValid = false;
    }

    if (password.length < 13) {
      showSnackbar(context, "Password length must be atleast 13 characters");
      _isValid = false;
    }

    return _isValid;
  }

  void _login() async {
    showSnackbar(context, "Logging in");
    var client = http.Client();

    try {
      var _url = Uri.parse("$url/api/auth/");
      var response = await client.post(
        _url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var token = body['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        final res = await prefs.setString('auth_token', token['auth_token']);

        if (res) {
          showSnackbar(context, body['msg']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => ChatsScreen()),
            ModalRoute.withName('/'),
          );
        }
      } else if (response.statusCode == 404) {
        showSnackbar(context, "User not found with that Email");
      } else {
        showSnackbar(context, "Server Down!");
      }
    } catch (e) {
      print(e);
      showSnackbar(context, "Something went wrong!");
    }
  }

  void _signup() async {
    showSnackbar(context, "Signing up");

    var client = http.Client();

    try {
      var _url = Uri.parse("$url/api/auth/signup");

      var response = await client.post(
        _url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        showSnackbar(context, body['msg']);
        _toggleLogin();
      } else {
        showSnackbar(context, "Error at Server");
      }
    } on SocketException {
      showSnackbar(context, "Unable to communicate with server!");
    } catch (e) {
      print("Exception $e");
      showSnackbar(context, "Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    String label = (_isLogin) ? "Login" : "Sign up";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 30, top: 10),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(width: double.infinity),
          Text(
            label,
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.headline4,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
            textAlign: TextAlign.center,
          ),
          LoginInput(
            controller: _emailController,
            label: "Email",
            keyboardType: TextInputType.emailAddress,
          ),
          PasswordInput(
            controller: _passwordController,
            label: "Password",
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(20),
            child: RoundedButton(
              title: label,
              onPressed: () {
                bool isValid = _validateFields();

                if (isValid) {
                  if (_isLogin) {
                    _login();
                  } else {
                    _signup();
                  }
                }
              },
            ),
          ),
          BottomRow(
              msgText: (_isLogin)
                  ? "Don't have an account?"
                  : "Already have an account?",
              btnText: (_isLogin) ? "Sign up" : "Login",
              onPressed: () {
                _toggleLogin();
              }),
        ],
      ),
    );
  }
}
