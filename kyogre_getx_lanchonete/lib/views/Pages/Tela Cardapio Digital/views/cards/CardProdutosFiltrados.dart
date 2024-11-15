import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:kyogre_getx_lanchonete/themes/cores.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/cards/AnimatedCardWidget.dart';
import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../../../../app/widgets/Utils/loading_widget.dart';
import '../../../../../controllers/DataBaseController/repository_db_controller.dart';
import '../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';

class CardsProdutosFIltrados extends StatefulWidget {
  final String categoria_selecionada;

  const CardsProdutosFIltrados(
      {super.key, required this.categoria_selecionada});

  @override
  State<CardsProdutosFIltrados> createState() => _CardsProdutosFIltradosState();
}

class _CardsProdutosFIltradosState extends State<CardsProdutosFIltrados> {
  @override
  Widget build(BuildContext context) {
    // Acessando os controladores
    final RepositoryDataBaseController repositoryController =
        Get.find<RepositoryDataBaseController>();
    final MenuProdutosRepository menuCategorias =
        Get.find<MenuProdutosRepository>();
    final MenuProdutosController menuController =
        Get.find<MenuProdutosController>();

    var produtos = repositoryController.dataBase_Array;
    var nomeCategoriaSelecionada = menuCategorias
        .MenuCategorias_Array[menuController.produtoIndex.value].nome;

    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: cor3,
      child: Column(
        children: [
          _headerProdutos(nomeCategoriaSelecionada),
          showProdutosFiltradosCategoria(nomeCategoriaSelecionada)
          //displayProdutosFiltradosCategoria(nome_categoria_selecionada),
        ],
      ),
    );
  }

  Widget _headerProdutos(categoriaSelecionada) {
    final MenuProdutosController menuController =
        Get.find<MenuProdutosController>();
    final MenuProdutosRepository menuCategorias =
        Get.find<MenuProdutosRepository>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: CupertinoColors.systemBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(height: 5, color: Colors.black),
          const Icon(CupertinoIcons.arrow_right_square_fill,
              color: Colors.white),
          const SizedBox(
            width: 16,
          ),
          CustomText(
            text: menuCategorias
                .MenuCategorias_Array[menuController.produtoIndex.value].nome,
            //text: '${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome} - ${menuController.produtoIndex.value}',
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget showProdutosFiltradosCategoria(String categoria) {
    final CardapioController cardapioController =
        Get.find<CardapioController>();

    var produtosOrdenados = cardapioController.repositoryController
        .filtrarEOrdenarPorNome(categoria);

    if (produtosOrdenados.isEmpty) {
      return const LoadingWidget();
    } else {
      // Exibir a lista de produtos filtrados
      return Expanded(
        child: ListView.builder(
          itemCount: produtosOrdenados.length,
          itemBuilder: (context, index) {
            var produto = produtosOrdenados[index];
            print(
                "\nProduto Selecionado = ${produto.nome} | ${produto.preco_1} | ${produto.categoria} | ${produto.sub_categoria} | ${produto.ingredientes} | ${produto.Adicionais}");

            return AnimatedProductCardWrapper(
              produto: produto,
              duration: const Duration(
                  milliseconds: 1000), // Ajuste a duração conforme necessário

              onTap: () {},
            );
          },
        ),
      );
    }
  }

  Widget _carregandoProdutos() {
    final RepositoryDataBaseController repositoryController =
        Get.find<RepositoryDataBaseController>();

    return FutureBuilder(
      future: repositoryController.getJsonFilesRepositoryProdutos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Ocorreu um erro ao carregar os produtos.'));
        } else {
          return Container(
            height: 500,
            color: Colors.purpleAccent,
            child: ListView(
              children: [
                Card(
                    color: Colors.blueGrey,
                    child: Text(
                        'Produtos JSON = ${repositoryController.dataBase_Array}')),
              ],
            ),
          );
        }
      },
    );
  }
}
