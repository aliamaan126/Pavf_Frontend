import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void SocketCLient(address) {
  IO.Socket socket = IO.io(address);
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));  
}