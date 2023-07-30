import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketController extends GetxController {
  final String serverUrl = 'http://localhost:8000';

  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.on('message', (data) {
      print('Received message: $data');
    });
  }

  void disconnectFromServer() {
    socket.disconnect();
  }
}
