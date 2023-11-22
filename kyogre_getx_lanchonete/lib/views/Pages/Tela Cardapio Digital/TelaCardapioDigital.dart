import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomAppBar.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/menu_tab_bar_widget.dart';
import '../../../models/DataBaseController/DataBaseController.dart';
import '../../../models/DataBaseController/Views/repositoryView.dart';
import '../../../models/DataBaseController/repository_db_controller.dart';
import '../CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../Carrinho/CarrinhoController.dart';
import '../Carrinho/CarrinhoPage.dart';
import '../Carrinho/modalCarrinho.dart';
import '../SplashScreen/splash_screen_page.dart';

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

  final DataBaseController _dataBaseController = DataBaseController();
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());

  //controllers
  final MenuProdutosController menuController =Get.put(MenuProdutosController());
  final MenuProdutosRepository menuCategorias = Get.put(MenuProdutosRepository());
  final RepositoryDataBaseController _repositoryController =Get.put(RepositoryDataBaseController());


  final _productsLoader = Completer<void>();

  // funcoes

  Future<void> loadProducts() async {

    await menuCategorias.getCategoriasRepository();
    await _repositoryController.loadData();

    await Future.delayed(Duration(seconds: 3));
    _productsLoader.complete(); // Complete o completer após o carregamento.

  }

  @override
  void initState() {
    super.initState();

    fetchClienteNome(widget.id);
    loadProducts();
  }

  Widget pegarDadosCliente() {
    return Column(
      children: [
        const Text('Dados do Cliente: '),
        Text('ID do Pedido: ${idPedido}'),

        ElevatedButton(onPressed: (){
          Get.to(RepositoryListView());
        }, child: Text('produdutos')),

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

    // Variaveis
    List nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];


    if (kIsWeb) {
      // Comportamento específico para a Web
      return buildWebPage();
    } else {
      // Comportamento para outras plataformas (móveis)
      return buildAppVersion();
    }


  }

Widget buildWebPage(){
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: CustomAppBar(
          id: widget.id,
        ),
        body:Center(

          child: ListView(children: [
            pegarDadosCliente(),
            Text('Visualizando em uma pagina WEB'),

            Obx(() => menuCategorias.isLoading.value ? const Card(
              child:  Column(children: [
                CustomText(text: 'Carregando Menu Scroll Gradiente...'),
                CircularProgressIndicator()
              ],),) : const MenuTabBarCardapio(),),

            //Container(            height: 150,            child: BarraInferiorPedido(),          )
            botaoVerCarrinho(),
          ]),

        ),
        floatingActionButton: FloatingActionButton(
          child: const Text('Abrir'),
          onPressed: () => Get.bottomSheet(
            BottomSheetWidget(
              nomeCliente: nomeCliente,
              telefoneCliente: telefoneCliente,
              id: widget.id,
            ),
          ),
        ));
}

  Widget buildAppVersion(){
    return Scaffold(
        appBar: AppBar(title: Text("Cardapio QR Code.key Digital App"),
        ),

        body: Center(
          child: Column(
            children: [
              Text('Visualizando em um dispositivo móvel'),
            ],
          ),
        )
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
                  text: 'item selecionado = ${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome}',
                  color: Colors.white,
                  size: 18,
                ),

              ],
            ))));
  }

  Widget botaoVerCarrinho() {
    return Padding(
        padding: const EdgeInsets.all(8),
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
}
