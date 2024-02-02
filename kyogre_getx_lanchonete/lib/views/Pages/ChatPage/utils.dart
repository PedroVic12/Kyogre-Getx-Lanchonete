
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'models.dart';

class UserConfig {
  static const String name = 'Naga Mobile 1';
}

class MessageTo extends StatelessWidget {
  const MessageTo({
    Key? key,
    required this.name,
    required this.message,
  }) : super(key: key);

  final String name;
  final String message;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      name: name,
      message: message,
      direction: MessageDirection.to,
    );
  }
}

class MessageFrom extends StatelessWidget {
  const MessageFrom({
    Key? key,
    required this.name,
    required this.message,
  }) : super(key: key);

  final String name;
  final String message;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      name: name,
      message: message,
      direction: MessageDirection.from,
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.name,
    required this.message,
    this.direction = MessageDirection.from,
  }) : super(key: key);

  final String name;
  final String message;
  final MessageDirection direction;

  @override
  Widget build(BuildContext context) {
    return _MessageContainer(
      messageDirection: direction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

enum MessageDirection {
  from,
  to,
}

class _MessageContainer extends Container {
  _MessageContainer({
    required Widget child,
    required MessageDirection messageDirection,
  }) : super(
    child: child,
    decoration: messageDirection == MessageDirection.from
        ? const BoxDecoration(
      color: Colors.amberAccent,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    )
        : const BoxDecoration(
      color: Color.fromARGB(255, 74, 200, 220),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    margin: messageDirection == MessageDirection.from
        ? const EdgeInsets.fromLTRB(100, 10, 10, 10)
        : const EdgeInsets.fromLTRB(10, 10, 100, 10),
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 15,
    ),
  );
}

class ListMessageView extends StatelessWidget {
  const ListMessageView({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            if (message.name == UserConfig.name) {
              return MessageFrom(
                name: message.name,
                message: message.text,
              );
            }
            return MessageTo(
              name: message.name,
              message: message.text,
            );
          },
        );
      },
    );
  }
}


class InputMessage extends StatefulWidget {
  const InputMessage({
    Key? key,
    required this.onSendMessage,
  }) : super(key: key);

  final void Function(String) onSendMessage;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  String _message = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 234, 234, 234),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 1,
              onChanged: (message) {
                _message = message;
              },
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            onPressed: () => _sendMessage(),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    widget.onSendMessage(_message);
    controller.text = '';
  }
}