import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

class CardDisplayProdutos extends StatefulWidget {
  @override
  _CardDisplayProdutosState createState() => _CardDisplayProdutosState();
}

class _CardDisplayProdutosState extends State<CardDisplayProdutos> {
  late PageController pageController;
  late MenuProdutosController menuController;

  @override
  void initState() {
    super.initState();
    menuController = Get.find<MenuProdutosController>(); // Encontre o controller existente
    pageController = PageController(initialPage: menuController.produtoIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Certifique-se de que o PageView seja atualizado para refletir o índice do produto atual
      if (menuController.produtoIndex.value != pageController.page?.round()) {
        pageController.jumpToPage(menuController.produtoIndex.value);
      }

      return Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                // Atualiza o produtoIndex quando a página é alterada pelo usuário
                menuController.produtoIndex.value = index;
              },
              itemCount: menuController.categorias_produtos_carregados.length,
              itemBuilder: (context, index) {
                // Chamada para o widget que constrói cada página de produto
                return _buildProdutoPage(menuController.categorias_produtos_carregados[index]);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildProdutoPage(CategoriaModel categoria) {
    // Construa a página do produto aqui usando o modelo CategoriaModel
    return Center(
      child: Card(
        child: ListTile(
          title: Text('Selecionado = ${categoria.nome}'),
          trailing: Text('Índice = ${menuController.produtoIndex.value}'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose(); // Não se esqueça de descartar o controlador da página
    super.dispose();
  }
}

