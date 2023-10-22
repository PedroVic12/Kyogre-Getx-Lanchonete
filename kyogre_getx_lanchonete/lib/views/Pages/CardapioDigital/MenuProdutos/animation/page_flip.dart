import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/animations_widgets.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/cards_produtos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/view/MenuCategoriasScroll.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:page_flip/page_flip.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';

class VirarPaginaAnimationWidget extends StatefulWidget {
  const VirarPaginaAnimationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<VirarPaginaAnimationWidget> createState() =>
      _VirarPaginaAnimationWidgetState();
}

class _VirarPaginaAnimationWidgetState
    extends State<VirarPaginaAnimationWidget> {
  // Controladores
  final MenuProdutosController menuController =
      Get.put(MenuProdutosController());
  final CatalogoProdutosController catalogoProdutosController =
      Get.put(CatalogoProdutosController());
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    menuController.getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Cardápio Digital',
          size: 20,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/carrinho');
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          MenuCategoriasScrollGradientWidget(onCategorySelected: (index) {
            currentPage = index;
            setState(() {});
          }),
          Expanded(
            child: Obx(() {
              var produtos = catalogoProdutosController.produtos;

              if (produtos.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return PageFlipWidget(
                  backgroundColor: Colors.grey,
                  lastPage: GestureDetector(
                    onTap: () {
                      if (currentPage <
                          catalogoProdutosController.catalogoCategorias.length -
                              1) {
                        currentPage++;
                        menuController.trocarItemSelecionado(currentPage);
                        setState(() {});
                      }
                    },
                    child: DetalhesProdutosCard(
                        key: ValueKey(menuController.produtoIndex.value)),
                  ),
                  duration: Duration(seconds: 1),
                  children: produtos.map((produto) {
                    return GestureDetector(
                      onTap: () {},
                      child: DetalhesProdutosCard(
                          key: ValueKey(menuController.produtoIndex.value)),
                    );
                  }).toList(),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

class ScrolCardapio extends StatefulWidget {
  const ScrolCardapio({super.key});

  @override
  State<ScrolCardapio> createState() => _ScrolCardapioState();
}

class _ScrolCardapioState extends State<ScrolCardapio> {
  final MenuProdutosController menuController =
      Get.put(MenuProdutosController());
  final CatalogoProdutosController catalogoProdutosController =
      Get.put(CatalogoProdutosController());
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    menuController.getCategorias();
    _pageController.addListener(() {
      int newPage = _pageController.page!.round();
      if (menuController.produtoIndex.value != newPage) {
        menuController.produtoIndex.value = newPage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Cardápio Digital',
          size: 20,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/carrinho');
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          MenuCategoriasScrollGradientWidget(onCategorySelected: (index) {
            _pageController.jumpToPage(index);
          }),
          Expanded(
            child: Obx(() {
              var produtos = catalogoProdutosController.produtos;
              if (produtos.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return PageView.builder(
                  controller: _pageController,
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    return DetalhesProdutosCard(
                      key: ValueKey(index),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
