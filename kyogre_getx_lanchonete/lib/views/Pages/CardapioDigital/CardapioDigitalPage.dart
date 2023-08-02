import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/Carrinho.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/MenuCategorias.dart';

import '../../../app/Teoria do Caos/CaosPage.dart';



class DetailsPage extends StatefulWidget {
  final String id;
   DetailsPage({required this.id, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? nomeCliente;
  String? telefoneCliente;
  final DataBaseController _dataBaseController = DataBaseController();

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
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Detalhes do Pedido ${widget.id}'),
      ),
      body: Center(
        child: Column(
          children: [

            // Dados do Cliente pelo Whatsapp
            Text('ID do Pedido: ${widget.id}'),
            if (nomeCliente != null)
              Text('Nome do Cliente: $nomeCliente'),
            if (telefoneCliente != null)
              Text('Telefone do Cliente: $telefoneCliente'),

            ElevatedButton(onPressed: (){
              Get.to(CaosPage());
            }, child: Text('Ver o CAOS')),


            // Menu Lateral com Scrol mostrando as categorias
            MenuCategorias(),

             // Lista de Produtos Selecionados
             CatalogoProdutos(),

            //Carrinho
            ElevatedButton(onPressed: (){
              Get.to(Carrinho());
            }, child: Text('Ver o Carrinho')),

          ],
        ),
      ),

    );
  }

}


