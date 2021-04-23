import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;

  const LoginInput({
    Key key,
    this.controller,
    this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          border: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.grey[300]),
          ),
          contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
