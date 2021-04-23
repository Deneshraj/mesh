import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  const RoundedButton({
    Key key,
    this.onPressed,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.nunito(
          textStyle: Theme.of(context).textTheme.headline6,
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
      ),
    );
  }
}
