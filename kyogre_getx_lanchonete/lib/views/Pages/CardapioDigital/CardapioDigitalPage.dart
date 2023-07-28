import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



//! DEEP LINKING
// O servidor Node.js (BackendController) gera um ID de pedido aleatório e constrói um link para o aplicativo Flutter na web com esse ID de pedido.
//
// O servidor Node.js envia esse link para o servidor FastAPI usando uma solicitação POST.
//
// O servidor FastAPI recebe o link e o armazena.
//
//  O servidor Node.js então envia uma mensagem para o cliente via WhatsApp com o link.
//
// O cliente clica no link no WhatsApp, que abre o aplicativo Flutter na web na página de detalhes do pedido correspondente ao ID no link.
//
// O cliente faz o pedido através do aplicativo Flutter na web.
//
// Quando o pedido é concluído, o aplicativo Flutter na web pode então enviar uma mensagem de volta para o servidor FastAPI com os detalhes do pedido.
//
// O servidor FastAPI pode processar o pedido como necessário (por exemplo, armazená-lo em um banco de dados, enviá-lo para um sistema de gerenciamento de pedidos, etc.). Se necessário, o servidor Node.js pode então enviar uma mensagem de confirmação para o cliente via WhatsApp.
//
// *//


class CardapioDigitalPage extends StatefulWidget {
  const CardapioDigitalPage({super.key});

  @override
  State<CardapioDigitalPage> createState() => _CardapioDigitalPageState();
}

class _CardapioDigitalPageState extends State<CardapioDigitalPage> {
  String? id;
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = Get.parameters['id']!;
  }

  Future<String?> getLinkPedidoServidor() async {
    final response = await http.get(
        Uri.parse('https://rayquaza-citta-server.onrender.com/receber-link'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['link'];
    } else {
      print('Failed to fetch the link.');
      return null;
    }
  }

  Future<void> sendLinkToServer(String link) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://rayquaza-citta-server.onrender.com/receber-link'), // Use o endereço IP da sua máquina aqui
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'link': link,
        }),
      );

      if (response.statusCode == 200) {
        print('Link enviado com sucesso!');
      } else {
        print('Falha ao enviar o link.');
      }
    } catch (e) {
      print('Nao foi possivel fazer o post no servidor');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardápio Digital'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                var id = Random().nextInt(10000);
                Get.toNamed('/details/$id');
              },
              child: Text('Generate novo Pedido'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar o item e a quantidade ao carrinho
                // ...

                // Enviar o link para o servidor
                sendLinkToServer('https://groundon-app.web.app/#/details/$id');
              },
              child: Text('Enviar o pedido para o Raquaza Server'),
            ),
          ],
        ),
      ),
    );
  }
}
