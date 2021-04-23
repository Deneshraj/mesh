import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const PasswordInput({Key key, this.controller, this.label}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
            labelText: widget.label,
            border: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey[300]),
            ),
            contentPadding: EdgeInsets.all(0),
            suffixIcon: GestureDetector(
              onTap: () {
                toggleVisibility();
              },
              child: Icon((_obscureText) ? Icons.visibility : Icons.visibility_off),
            )),
      ),
    );
  }
}