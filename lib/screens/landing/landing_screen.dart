import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh/screens/auth/login_screen.dart';
import 'package:mesh/screens/components/rounded_button.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = "LandingScreen";
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Text(
                "Welcome to Mesh",
                style: GoogleFonts.nunito(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text("Where you can chat freely and securely!"),
              Spacer(flex: 1),
              Container(
                width: size.width * 0.8,
                child: RoundedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  title: "Get Started",
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
