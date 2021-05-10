import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh/constants.dart';
import 'package:mesh/utils/functions.dart';
import 'package:mesh/utils/requests.dart';

class MessageScreen extends StatefulWidget {
  final String id;
  final String username;

  const MessageScreen({Key key, this.id, this.username}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List _chats = [];
  bool _isLoaded = false;
  TextEditingController _inputController = TextEditingController();

  _getChats() async {
    bool res = await sendAuthorizedReq(
      func: (token) async {
        var response = await post(
          Uri.parse("$url/api/chats/"),
          token,
          jsonEncode({
            'to_user': widget.id,
          }),
        );
        var body = jsonDecode(response.body);
        setState(() {
          _chats = body['chats'];
          _isLoaded = true;
          _inputController.text = "";
        });
      },
    );

    if (!res) {
      setState(() {
        _chats = [];
      });
    }
  }

  _sendChat() async {
    sendAuthorizedReq(
      func: (token) async {
        var response = await post(
            Uri.parse("$url/api/chats/add/"),
            token,
            jsonEncode({
              'message': _inputController.text,
              'to_user': widget.id,
            }));
        var body = jsonDecode(response.body);
        setState(() {
          _chats.add(body['chat']);
          _inputController.text = "";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_chats == null || _isLoaded == false) {
      _getChats();
    }

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: (_chats != null) ? _chats.length : 0,
                itemBuilder: (context, index) {
                  bool currentUser =
                      _chats[index]['to_user']['id'] == widget.id;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    alignment: (currentUser)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 0.85,
                        vertical: kDefaultPadding / 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: (currentUser) ? kPrimaryColor : Colors.grey[300],
                      ),
                      child: Text(_chats[index]['message'],
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: (currentUser) ? Colors.white : Colors.black,
                          )),
                    ),
                  );
                }),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kPrimaryColor.withAlpha(30),
                      ),
                      child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter a Message",
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          suffixIcon: Icon(Icons.mic),
                        ),
                        controller: _inputController,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String text = _inputController.text;
                      _sendChat();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    ),
                    child: Icon(
                      Icons.send,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
