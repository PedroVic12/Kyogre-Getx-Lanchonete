import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';

import '../../../views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../../../views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../../views/Pages/Tela Cardapio Digital/controllers/pikachu_controller.dart';
import '../repository_db_controller.dart';
import '../template/produtos_model.dart';

class RepositoryListView extends StatefulWidget {
  @override
  _RepositoryListViewState createState() => _RepositoryListViewState();
}

class _RepositoryListViewState extends State<RepositoryListView> {
  final RepositoryDataBaseController controller =
      Get.put(RepositoryDataBaseController());

  final String sanduicheFile = 'lib/repository/models/sanduiches.json';
  var ulr2 = 'https://www.npoint.io/docs/ae829694539a3375241e';
  var url1 = 'https://api.npoint.io/796847de75f3705645c2';
  final List array = [].obs;
  var products;

  readingDataJson(url) async {
    Dio api = Dio();

    var response = await api.get(url);

    var produtos = response.data;

    return produtos;
  }

  Future<List> setupPage() async {
    // Limpa o array existente
    controller.dataBase_Array.clear();

    // Lê os dados JSON
    List itemsJson = await readingDataJson(url1);
    controller.pikachu.cout('JSON = ${itemsJson}');

    // Transforma em Objeto dart
    itemsJson.forEach((element) {
      products = ProdutoModel.fromJson(element);
      controller.pikachu.cout(products.categoria);

      // Adiciona os objetos ao array do controlador
      controller.dataBase_Array.add(products);
    });

    controller.pikachu.cout('FIX HERE =  ${controller.dataBase_Array[0]}');

    print('\n\n\nDatabase Carregado!');
    return controller.dataBase_Array;
  }

  Future<List> _carregandoArrayObjetos() async {
    array.clear();

    var jsonData = await readingDataJson(url1);
    controller.pikachu.cout('JSON = ${jsonData}');

    List<dynamic> produtos =
        jsonData.map((item) => ProdutoModel.fromJson(item)).toList();
    controller.pikachu.cout('Produto: ${produtos} ');

    // Exemplo de uso
    for (var produto in produtos) {
      controller.pikachu
          .cout('Produto: ${produto.nome}, Categoria: ${produto.categoria}');
      array.add(produto);
    }
    setState(() {
      // Isto irá reconstruir a UI com os dados carregados
    });
    return array;
  }

  void initPage() async {
    //await setupPage();
    await Future.delayed(Duration(seconds: 1), () async {
      _carregandoArrayObjetos();
    });
  }

  @override
  void initState() {
    super.initState();
    initPage();
    Future.delayed(Duration(seconds: 5), () async {
      controller.pikachu.loadDataSuccess(':)', 'Tudo carregado');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Produtos - REPOSITORY'),
        ),
        body: ListView(
          children: [
            Container(
                color: Colors.white,
                height: 500,
                child: Obx(() {
                  if (array.isEmpty) {
                    return LoadingWidget();
                  } else {
                    return ListView.builder(
                      itemCount: array.length,
                      itemBuilder: (context, index) {
                        var item = array[index];
                        return ListTile(
                            title: CustomText(
                              text: 'Array = ${array}',
                            ),
                            subtitle: Column(
                              children: [
                                CustomText(
                                  text: '\n\nProduto: ${item.nome}',
                                ),
                                CustomText(
                                    text: 'Categoria: ${item.categoria}'),
                                CustomText(text: 'Precos: ${item.precos}')
                              ],
                            ));
                      },
                    );
                  }
                })),

            // buildListViewProdutosRepository()
          ],
        ));
  }

  Widget _list() {
    return Obx(() {
      if (array.isEmpty) {
        return Center(child: LoadingWidget());
      } else {
        return ListView.builder(
          itemCount: array.length,
          itemBuilder: (context, index) {
            var produto = array[index];
            return ListTile(
              title: Text(produto.nome),
              subtitle: Text('Categoria: ${produto.categoria}'),
            );
          },
        );
      }
    });
  }

  Widget buildListViewProdutosRepository() {
    return Center(
        child: Column(
      children: [
        _list(),
        _builderListView(),
        _builderListController(),
        _obxList()
      ],
    ));
  }

  Widget _buildListCategorias() {
    return Container();
  }

  Widget _builderListView() {
    return GetBuilder<RepositoryDataBaseController>(
        init:
            RepositoryDataBaseController(), // Inicialize o controlador se necessário
        builder: (controller) {
          // Aqui você pode acessar os dados do controlador e construir sua UI
          return CustomText(text: 'Array = ${controller.dataBase_Array}');
        });
  }

  Widget _builderListController() {
    return GetX<RepositoryDataBaseController>(
        init:
            RepositoryDataBaseController(), // Inicialize o controlador se necessário
        builder: (controller) {
          // Construa sua UI com os dados do controlador
          return CustomText(text: 'Array = ${controller.dataBase_Array}');
        });
  }

  Widget _obxList() {
    final controller = Get.find<
        RepositoryDataBaseController>(); // Obtém a instância do controlador

    return Container(
        child: Obx(() => Card(
              child: Column(
                children: [
                  CustomText(text: 'Array = ${controller.dataBase_Array}'),
                ],
              ),
            )) // Substitua `someData` pelo dado observável
        );
  }
}
