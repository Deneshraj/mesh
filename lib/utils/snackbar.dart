import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 2),
    ),
  );
}
