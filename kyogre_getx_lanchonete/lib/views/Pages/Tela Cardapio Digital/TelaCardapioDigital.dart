import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomAppBar.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/rounded_appbar.dart';

import '../../../app/widgets/Barra Inferior/BarraInferior.dart';
import '../../../models/DataBaseController/DataBaseController.dart';
import '../../../models/DataBaseController/models/pizza.dart';
import '../../../models/DataBaseController/repository_db_controller.dart';
import '../../../models/DataBaseController/template/produtos_model.dart';
import '../CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import '../CardapioDigital/MenuProdutos/Cards/card_produto_selecionado.dart';
import '../CardapioDigital/MenuProdutos/Tab Bar/tab_bar_widget.dart';
import '../CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../Carrinho/CarrinhoController.dart';
import '../Carrinho/CarrinhoPage.dart';
import '../Carrinho/modalCarrinho.dart';

/*
* Paleta de Cores : #ff8c00 , #f2ff00, # ff0d00
*
* page_turn
* glass_kit
* */



class TelaCardapioDigital extends StatefulWidget {
  final String id;
  const TelaCardapioDigital({super.key, required this.id});

  @override
  State<TelaCardapioDigital> createState() => _TelaCardapioDigitalState();
}

class _TelaCardapioDigitalState extends State<TelaCardapioDigital> {

  //variaveis dinamicas
  late String nomeCliente = "";
  late String telefoneCliente = "";
  late String idPedido = "";

  //controllers
  final DataBaseController _dataBaseController = DataBaseController();
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  final RepositoryDataBaseController _repositoryController = Get.put(RepositoryDataBaseController());



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
    final MenuProdutosController menuController =   Get.put(MenuProdutosController());
    final CatalogoProdutosController _controller = CatalogoProdutosController();

    // Variaveis
    List nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

    return Scaffold(
        backgroundColor: Colors.red,
        appBar: CustomAppBar(),
        body: Center(
        child: ListView(children: [

        pegarDadosCliente(),


          TabBarWidget(),





          botaoVerCarrinho(),

          //Container(            height: 150,            child: BarraInferiorPedido(),          )


        ]

    ),),
          floatingActionButton: FloatingActionButton(
          child: Text('Abrir'),
    onPressed: () => Get.bottomSheet(
    BottomSheetWidget(
    nomeCliente: nomeCliente,
    telefoneCliente: telefoneCliente,
    id: widget.id,
    ),
    ),));
  }

  Widget botaoVerCarrinho(){
    return  Padding(
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
                ))));
  }


}

