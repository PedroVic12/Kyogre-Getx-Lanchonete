import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/app/widgets/Categorias/CategoriasWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/Carrinho.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutos.dart';



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

            CategoriasWidget(),

             CatalogoProdutos(),

            ElevatedButton(onPressed: (){
              Get.to(Carrinho());
            }, child: Text('Ver o Carrinho'))

          ],
        ),
      ),
    );
  }

}


