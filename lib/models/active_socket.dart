import 'package:flutter/material.dart';
import 'package:mesh/constants.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ActiveSocket with ChangeNotifier {
  Socket _socket;

  ActiveSocket() {
    _socket = _socketConn();
  }

  Socket get socket => _socket;

  Socket _socketConn() {
    Socket socket = io(sioUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((_) => print("Connected!"));
    socket.onConnectError((data) {
      print(data);
      notifyListeners();
    });
    socket.onConnectTimeout((_) {
      print("Timeout!");
      notifyListeners();
    });
    socket.onDisconnect((_) {
      notifyListeners();
    });
    return socket;
  }

  void disposeSocket() {
    socket.close();
    notifyListeners();
  }
}