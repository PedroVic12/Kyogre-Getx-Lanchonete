import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:web_socket_channel/io.dart';

import '../models.dart';
import '../utils.dart';



class MessageService{
  late IOWebSocketChannel channel;

  Future initConnection() async {
    channel = IOWebSocketChannel.connect(
      "wss://url",
      headers: {},
      pingInterval: const Duration(seconds: 5)
    );
  }

  void enviarMensagem(Message message){
    channel.sink.add(jsonEncode(message.toJson()));
  }

  Future _retryConnection({
    required void Function(Message) onReceive,
  }) async {
    await Future.delayed(const Duration(seconds: 5));
    await initConnection();
    await broadcastNotifications(
      onReceive: onReceive,
    );
  }
  Future broadcastNotifications({
    required void Function(Message) onReceive,
  }) async {
    channel.stream.listen(
          (event) {
        final Map<String, dynamic> json = jsonDecode(event);
        final message = Message.fromJson(json);
        onReceive(message);
      },
      onError: (_) async {
        _retryConnection(onReceive: onReceive);
      },
      onDone: () async {
        _retryConnection(onReceive: onReceive);
      },
      cancelOnError: true,
    );
  }
}




 class ChatControllerBase with Store {
  MessageService messageService = MessageService();

  @observable
  ObservableList<Message> messages = ObservableList<Message>();

  @action
  void sendMessage(String text) {
    final message = Message(
      name: UserConfig.name,
      text: text,
    );
    messages.add(message);
    messageService.enviarMensagem(message);
  }

  Future init() async {
    await messageService.initConnection();
    await messageService.broadcastNotifications(
      onReceive: (message) {
        messages.add(message);
      },
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatControllerBase controller = ChatControllerBase();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat do Pub Dev'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListMessageView(
              messages: controller.messages,
            ),
          ),
          InputMessage(
            onSendMessage: controller.sendMessage,
          ),
        ],
      ),
    );
  }
}