import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/produtos_card.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';

import '../MenuProdutos/animation/MenuCategoriasScroll.dart';

class CardapioProdutosWidget extends StatefulWidget {
  const CardapioProdutosWidget({super.key});

  @override
  State<CardapioProdutosWidget> createState() => _CardapioProdutosWidgetState();
}

class _CardapioProdutosWidgetState extends State<CardapioProdutosWidget> {
  final MenuProdutosController menuController = Get.put(MenuProdutosController());
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // Carregar os dados necessários ou configurar o controlador aqui, se necessário.
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Supondo que você tem uma lista de produtos no seu MenuProdutosController
    List<CategoriaModel> produtos = menuController.produtos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Lanchonete'),
      ),
      body: Column(
        children: [
          MenuCategoriasScrollGradientWidget(
            onCategorySelected: (index) {
              pageController.jumpToPage(index);
            },
          ),
          Expanded(
            child: ProdutoDetalhesView(
              pageController: pageController,
              produtoSelecionadoIndex: menuController.produtoIndex, // Seu RxInt que rastreia o índice selecionado
              produtos: produtos,
            ),
          ),
        ],
      ),
    );
  }
}
