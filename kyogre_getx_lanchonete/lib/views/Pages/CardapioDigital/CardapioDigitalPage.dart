import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({required this.id, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? nomeCliente;
  String? telefoneCliente;

  @override
  void initState() {
    super.initState();
    fetchClienteNome();
  }

  Future<void> fetchClienteNome() async {
    final response = await http.get(
        Uri.parse('https://rayquaza-citta-server.onrender.com/cliente/${widget.id}'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        nomeCliente = data['nome'];
        telefoneCliente = data['telefone'];
      });
    } else {
      print('Failed to fetch the client name.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido ${widget.id}'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('ID do Pedido: ${widget.id}'),
            if (nomeCliente != null)
              Text('Nome do Cliente: $nomeCliente'),
            if (telefoneCliente != null)
              Text('Telefone do Cliente: $telefoneCliente'),
          ],
        ),
      ),
    );
  }

}
