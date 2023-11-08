import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/MenuCategoriasScroll.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';

import '../../../../../models/DataBaseController/DataBaseController.dart';


class PageViewScrolCardapio extends StatefulWidget {
  const PageViewScrolCardapio({super.key});

  @override
  State<PageViewScrolCardapio> createState() => _PageViewScrolCardapioState();
}

class _PageViewScrolCardapioState extends State<PageViewScrolCardapio> {
  final CatalogoProdutosController catalogoProdutosController = Get.find<CatalogoProdutosController>();
  final MenuProdutosController menuController = Get.find<MenuProdutosController>();
  final PageViewController pageController = Get.put(PageViewController());

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final produtos = catalogoProdutosController.produtos;

    return Scaffold(
      appBar: AppBar(title: Text('Cardapio Digital')),
      body: Column(
        children: [


          MenuCategoriasScrollGradientWidget(
            onCategorySelected: (index) {
              menuController.produtoIndex.value = index;
            },
          ),



          Obx(() => CustomText(text: 'Index = ${menuController.produtoIndex.value}'),),

          Container(
            color: Colors.greenAccent,
            child:    SizedBox(
              height: 200,
              child:  CustomTabBarWidget(
                pageController: pageController,
              ),
            ),
          ),



        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class PageViewController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  var myTabs = <Tab>[].obs;
  final MenuProdutosController menuController = Get.find<MenuProdutosController>();

  @override
  void onInit() {
    super.onInit();
    loadTabs();
  }

  void loadTabs() {
    // Obtenha as categorias de produtos
    var categoriasProdutos = menuController.fetchCategorias();

    // Limpa a lista de abas para evitar duplicatas
    myTabs.clear();

    // Cria as abas baseadas nas categorias de produtos
    myTabs.addAll(categoriasProdutos.map((categoria) => Tab(text: categoria.nome)).toList());

    // Inclui outras abas que são fixas
    myTabs.addAll([
      Tab(text: 'Status'),
      Tab(text: 'Calls'),
    ]);

    // Inicializa o TabController com o número correto de abas
    tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}


class CustomTabBarWidget extends StatelessWidget {
  final PageViewController pageController;

  CustomTabBarWidget({required this.pageController});

  @override
  Widget build(BuildContext context) {
    // Use Obx para escutar mudanças na lista de abas
    return Obx(() {
      // Certifique-se de que o TabController foi inicializado
      if (pageController.myTabs.isEmpty) {
        return Container(); // Ou algum widget de carregamento
      }

      return Column(
        children: <Widget>[
          TabBar(
            controller: pageController.tabController,
            tabs: pageController.myTabs,
          ),
          Expanded(
            child: TabBarView(
              controller: pageController.tabController,
              children: pageController.myTabs.map((tab) {
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
