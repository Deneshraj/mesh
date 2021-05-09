import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:mesh/utils/requests.dart';

import '../../../constants.dart';
import '../../../utils/functions.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List _friends;
  bool _isLoaded = false;

  _getFriends() async {
    String token = await getToken();
    if (token.isNotEmpty) {
      var response = await getReq(
        Uri.parse("$url/api/user/friends"),
        token,
      );
      var body = jsonDecode(response.body);
      setState(() {
        _friends = body['friends'];
        _isLoaded = true;
      });
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    if (_friends == null || _isLoaded == false) {
      _getFriends();
    }

    return Container(
      child: ListView.builder(
          itemCount: (_friends != null) ? _friends.length : 0,
          itemBuilder: (BuildContext context, int index) {
            String imageUrl = _friends[index]['profilePicUrl'];
            if (imageUrl == null) imageUrl = "";
            String username = "${_friends[index]['username']}";

            return InkWell(
              onTap: () {
                print(index);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    (imageUrl.isNotEmpty)
                        ? CircleAvatar(
                            radius: 30.0,
                            backgroundImage: (_friends[index]['profilePicUrl']))
                        : CircleAvatar(
                            radius: 27.0,
                            child: Text(
                              _friends[index]['username']
                                  .toString()
                                  .substring(0, 2),
                              style:
                                  Theme.of(context).textTheme.headline6.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                            ),
                          ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "hey, how are you?",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
