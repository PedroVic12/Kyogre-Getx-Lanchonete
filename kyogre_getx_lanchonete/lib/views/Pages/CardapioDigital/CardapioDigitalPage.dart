import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';

import '../../../app/Teoria do Caos/CaosPage.dart';

/*
* Paleta de Cores : #ff8c00 , #f2ff00, # ff0d00
* */

class DetailsPage extends StatefulWidget {
  final String id;

  DetailsPage({required this.id, Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late String nomeCliente = "";
  late String telefoneCliente = "";
  late String idPedido = "";

  final DataBaseController _dataBaseController = DataBaseController();
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  @override
  void initState() {
    super.initState();

    //fetchIdPedido().then((idPedido) {
      //print(idPedido);
      //fetchClienteNome(idPedido);
    //});

    fetchClienteNome(widget.id);
  }

  Future<String> fetchIdPedido() async {
    final response_id = await http.get(Uri.parse('https://rayquaza-citta-server.onrender.com/receber-link'));

    if (response_id.statusCode == 200) {
      String id_data = response_id.body;
      print(id_data);
      return id_data;
    }

    else {
      throw Exception('Failed to fetch ID');
    }
  }


  Future<void> fetchClienteNome(String clienteId) async {
    final response = await http.get(Uri.parse(
        'https://rayquaza-citta-server.onrender.com/cliente/$clienteId'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        idPedido = data['id'];
        nomeCliente = data['nome'];
        telefoneCliente = data['telefone'];
        super.initState();
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
        title: Center(child: Text('Citta Lanchonete {nome} Pedido: ${widget.id}')),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(children: [
          Text('Dados do Cliente: '),

          // Dados do Cliente pelo Whatsapp
          Text('ID do Pedido: ${idPedido}'),
          Text('Nome do Cliente: $nomeCliente'),
          Text('Telefone do Cliente: $telefoneCliente'),

          // Lista de Produtos Selecionados
          Expanded(
            child: CatalogoProdutos(),
          ),

          //Carrinho
          Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        carrinhoController.setClienteDetails(
                            nomeCliente, telefoneCliente, widget.id);
                        Get.to(CarrinhoPage(), arguments: [
                          nomeCliente,
                          telefoneCliente,
                          widget.id
                        ]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        'Ver o Carrinho',
                        style: TextStyle(fontSize: 22),
                      )))),
        ]),
      ),
    );
  }
}
