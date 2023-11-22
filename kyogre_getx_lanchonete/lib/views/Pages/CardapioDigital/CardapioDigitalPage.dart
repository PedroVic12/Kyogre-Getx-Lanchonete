import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/Views/produtos_display_listview.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/models/pizza.dart';

import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/cards_produtos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/modalCarrinho.dart';
import '../../../app/widgets/Custom/CustomText.dart';
import '../../../models/DataBaseController/repository_db_controller.dart';
import '../../../models/DataBaseController/template/produtos_model.dart';

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
  //variaveis dinamicas
  late String nomeCliente = "";
  late String telefoneCliente = "";
  late String idPedido = "";

  //controllers
  final DataBaseController _dataBaseController = DataBaseController();
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  final RepositoryDataBaseController _repositoryController =
      Get.put(RepositoryDataBaseController());

  @override
  void initState() {
    super.initState();
    fetchClienteNome(widget.id);
  }

  Widget pegarDadosCliente() {
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
    final response_id = await http.get(
        Uri.parse('https://rayquaza-citta-server.onrender.com/receber-link'));

    if (response_id.statusCode == 200) {
      String id_data = response_id.body;
      print(id_data);
      return id_data;
    } else {
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
    //controllers
    final MenuProdutosController menuController =
        Get.put(MenuProdutosController());
    final CatalogoProdutosController _controller = CatalogoProdutosController();

    // Variaveis
    List<ProdutoModel> produtos =
        PIZZA_OBJECT.map((json) => ProdutoModel.fromJson(json)).toList();
    List nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Center(
            child: Text('Citta RJ ${nomesLojas[1]} | Pedido: ${widget.id}')),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Hide the back button
      ),
      body: Center(
        child: Column(children: [
          pegarDadosCliente(),

          //_carregandoProdutos(),


          _indexProdutoSelecionado(),

          botaoVerCarrinho()
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

  Widget botaoVerCarrinho() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  carrinhoController.setClienteDetails(
                      nomeCliente, telefoneCliente, widget.id);
                  Get.to(CarrinhoPage(),
                      arguments: [nomeCliente, telefoneCliente, widget.id]);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.activeBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text(
                  'Ver o Carrinho',
                  style: TextStyle(fontSize: 22),
                ))));
  }

  Widget _carregandoProdutos() {
    return FutureBuilder<List<List<ProdutoModel>>>(
      future: _repositoryController.fetchAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Ocorreu um erro ao carregar os produtos.'));
        } else {
          return Container(
            height: 200,
            color: Colors.purpleAccent,
            child: ListView(
              children: [
                Container(
                    color: Colors.blueGrey,
                    child: Text(
                        'Produtos JSON = ${_repositoryController.dataBaseArrayJson}')),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _indexProdutoSelecionado() {
    final MenuProdutosController menuController =Get.find<MenuProdutosController>();

    return Container(
        color: Colors.black,
        child: Obx(() => Center(
                child: Column(
              children: [
                CustomText(
                  text: 'item selecionado = ${menuController.produtoIndex}',
                  color: Colors.white,
                ),

              ],
            ))));
  }
}
