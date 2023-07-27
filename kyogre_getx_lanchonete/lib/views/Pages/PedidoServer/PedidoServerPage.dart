import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:get/get.dart';


class PedidoPage extends StatefulWidget {
  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  final WebSocketChannel channel =
  IOWebSocketChannel.connect('ws://localhost:8000/pedido');
  final mensagem = ''.obs;

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar Pedido'),
      ),
      body: Center(
        child: Obx(
              () => mensagem.value.isNotEmpty
              ? Text('Resposta do servidor: ${mensagem.value}')
              : Text('Aguardando resposta do servidor...'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => enviarPedido(),
        child: Icon(Icons.send),
      ),
    );
  }

  void enviarPedido() {
    channel.sink.add('Pedido');

    channel.stream.listen(
          (data) {
        setState(() {
          mensagem.value = data;
        });
      },
      onError: (error) {
        print('Error: $error');
      },
      onDone: () {
        print('Connection closed');
      },
    );
  }
}