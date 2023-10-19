import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/modalCarrinho.dart';

import '../../../app/Teoria do Caos/CaosPage.dart';
import '../../../app/widgets/Barra Inferior/BarraInferior.dart';
import 'MenuProdutos/WidgetCardapio.dart';
import 'MenuProdutos/menu_lateral.dart';

/*
* Paleta de Cores : #ff8c00 , #f2ff00, # ff0d00
*
* page_turn
* glass_kit
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


  //final DataBaseController _dataBaseController = DataBaseController();
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  @override
  void initState() {
    super.initState();
    fetchClienteNome(widget.id);
  }

  Widget pegarDadosCliente(){
    return Column(
      children: [
        Text('Dados do Cliente: '),
        Text('ID do Pedido: ${idPedido}'),
        Text('Nome do Cliente: $nomeCliente'),
        Text('Telefone do Cliente: $telefoneCliente'),

      ],
    );
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


  List nomesLojas = ['Copacabana', 'Botafogo' , 'Ipanema', 'Castelo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Center(child: Text('Citta RJ ${nomesLojas[1]} | Pedido: ${widget.id}')),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Hide the back button
      ),
      body: Center(
        child: ListView(children: [

          pegarDadosCliente(),

          MenuCategoriasScrollGradientWidget(),

          // Renderizar o cartão do produto selecionado somente se um produto estiver selecionado.
          Card(child: DetalhesProdutosCard()),


         CatalogoProdutos(), // tinha um expanded aqui e faz sentido pelo tamanho do conteudo


          //botao Carrinho
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

      floatingActionButton: FloatingActionButton(
        child: Text('Abrir'),
        onPressed: () => Get.bottomSheet(
          BottomSheetWidget(
            nomeCliente: nomeCliente,
            telefoneCliente: telefoneCliente,
            id: widget.id,
          ),
        ),
      ),

    );
  }









}


