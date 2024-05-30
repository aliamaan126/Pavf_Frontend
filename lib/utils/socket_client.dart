import 'package:PAVF/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  IO.Socket? _socket;

  IO.Socket? get socket => _socket;

  SocketService() {
    _connect();
  }

  void _connect() {
    _socket = IO.io(socketIp, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket?.connect();
    

    _socket?.onConnect((_) {
      print('connected to server');
    });

    _socket?.onDisconnect((_) => print('disconnected from server'));
  }

  void emitAction(String action, dynamic data) {
    _socket?.emit(action, data);
  }

  @override
  void dispose() {
    _socket?.disconnect();
    super.dispose();
  }
}
