import 'dart:async';

class StreamSocket {
  final _socketResponse= StreamController();

  set addResponse(dynamic) => _socketResponse.sink.add;

  Stream get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}