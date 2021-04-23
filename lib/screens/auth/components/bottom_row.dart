import 'package:flutter/material.dart';

class BottomRow extends StatelessWidget {
  final String msgText;
  final String btnText;
  final Function onPressed;

  const BottomRow({
    Key key,
    this.msgText,
    this.btnText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(msgText),
        TextButton(
          onPressed: onPressed,
          child: Text(btnText),
        ),
      ],
    );
  }
}
