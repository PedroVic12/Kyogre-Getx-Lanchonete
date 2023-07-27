import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
