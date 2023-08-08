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
  late String nomeCliente;
  late String telefoneCliente;
  bool isDevelopment = false; //TODO Defina como false quando não estiver em modo de PRODUÇÃO


  final DataBaseController _dataBaseController = DataBaseController();
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  @override
  void initState() {
    super.initState();
    fetchClienteNome();
  }

  Future<void> fetchClienteNome() async {

    if (isDevelopment) {
      setState(() {
        nomeCliente = "Cliente Teste";
        telefoneCliente = "1234-5678";
      });
      return;
    }


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
        backgroundColor: Colors.black,

      ),
      body: Center(
        child: Column(
          children: [

            // Dados do Cliente pelo Whatsapp
            Text('ID do Pedido: ${widget.id}'),
              Text('Nome do Cliente: $nomeCliente'),
              Text('Telefone do Cliente: $telefoneCliente'),


            // Lista de Produtos Selecionados
            Expanded(
              child: CatalogoProdutos(),
            ),

            //Carrinho
            Padding(padding: EdgeInsets.all(8),child:
            SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(onPressed: (){
                  carrinhoController.setClienteDetails(nomeCliente, telefoneCliente, widget.id);
                  Get.to(CarrinhoPage(), arguments: [nomeCliente, telefoneCliente, widget.id]);                }, style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.activeBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                    child: const Text('Ver o Carrinho', style: TextStyle(fontSize: 22),))

            )
            ),


          ]
        ),
      ),

    );
  }

}


