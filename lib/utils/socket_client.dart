import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void socketCLient(address) {
  IO.Socket socket = IO.io(address);
  socket.onConnect((_) {
    print('connect');
  });
}