import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

import '../produtos_controller.dart';
import 'controllers/page_view_controller.dart';

class CustomTabBarWidget extends StatelessWidget {
  final PageViewController pageController;

  CustomTabBarWidget({required this.pageController});

  @override
  Widget build(BuildContext context) {
    // Use Obx para escutar mudanças na lista de abas
    return Obx(() {
      // Certifique-se de que o TabController foi inicializado
      if (pageController.myTabs_array.isEmpty) {
        return Container(); // Ou algum widget de carregamento
      }

      return Column(
        children: <Widget>[
          TabBar(
            controller: pageController.tabController,
            tabs: pageController.myTabs_array,
          ),
          Expanded(
            child: TabBarView(
              controller: pageController.tabController,
              children: pageController.myTabs_array.map((tab) {
                // Aqui você criaria uma visualização para cada aba baseada em seu índice
                return Center(child: Column(children: [
                  Text('Conteúdo para ${tab.text}'),
                  cardDisplayProdutos()
                ],));
              }).toList(),
            ),
          ),
        ],
      );
    });
  }


  Widget _buildCategoriaItem(BuildContext context, int index) {
    final MenuProdutosController menuController = Get.find<MenuProdutosController>();
    final isSelected = menuController.produtoIndex.value == index;
    final List<CategoriaModel> categoriasProdutos;

    void _onCategoriaTap(int index) {
      menuController.setProdutoIndex(index); // Atualiza o índice no controller
    }


    return Obx(() {
      if (pageController.myTabs_array.isEmpty) {
        return Container(
          color: Colors.lime,
          child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        );
      } else {
        return GestureDetector(
          onTap: () => _onCategoriaTap(index),
          child: Container(
            width: 110,
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0.5, 1),
                  blurRadius: 50,
                  spreadRadius: 3,
                  color: Colors.yellow.shade300,
                ),
              ],
              gradient: isSelected
                  ? LinearGradient(colors: [
                Colors.deepPurple.shade100,
                CupertinoColors.activeBlue.highContrastElevatedColor
              ])
                  : null,
            ),
            child: Center(
                child: ProdutosDetails(
                  nome: pageController.categoriasProdutos[index].nome,
                  imagem_produto: pageController.categoriasProdutos[index]
                      .iconPath,
                )
            ),
          ),
        );
      }


      // Seu código de renderização de abas
    });
  }

  Widget cardDisplayProdutos(){
    final MenuProdutosController menuController = Get.find<MenuProdutosController>(); // Encontre o controller já existente

    final categoriaProduto = menuController.categorias_produtos_carregados[menuController.produtoIndex.value]; // Use o índice observável para obter o produto atual

    return Card(
      color: Colors.blueAccent,
      child: CupertinoListTile(
        title: Text('Selecionado = ${categoriaProduto.nome}'),
        trailing: Text('Índice = ${menuController.produtoIndex}'),
      ),
    );
  }
}
