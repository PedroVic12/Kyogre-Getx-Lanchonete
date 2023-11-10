import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/MenuCategoriasScroll.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/cardapio_scroll_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

import 'controllers/page_view_controller.dart';

class TabViewScrollCardapio1 extends StatefulWidget {
  const TabViewScrollCardapio1({super.key});

  @override
  State<TabViewScrollCardapio1> createState() => _TabViewScrollCardapio1State();
}

class _TabViewScrollCardapio1State extends State<TabViewScrollCardapio1> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageViewController pageController = Get.find<PageViewController>();

  @override
  void initState() {
    super.initState();
    // Carrega as categorias antes de inicializar o TabController
    pageController.loadTabs().then((_) {
      setState(() {
        // Inicializa o TabController
        _tabController = TabController(vsync: this, length: pageController.categoriasProdutos.length);
      });
    });
  }

  Future<void> _loadCategories() async {
    await pageController.loadTabs(); // Certifique-se de que esta função carrega as categoriasProdutos
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) {
      return Center(child: CircularProgressIndicator()); // Exibir um indicador de carregamento até que as categorias sejam carregadas
    }

    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          tabs: pageController.categoriasProdutos.map((categoria) => Tab(text: categoria.nome)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: pageController.categoriasProdutos.map((categoria) {
              return buildCategoriaCard(categoria); // Cria um card para cada categoria
            }).toList(),
          ),
        ),
      ],
    );
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  Widget _buildTabView(){

    final PageViewController pageController = Get.find<PageViewController>();

    return TabBarView(
      controller: _tabController,
      children: pageController.categoriasProdutos.map((categoria) {
        return buildCategoriaCard(categoria); // Cria um card para cada categoria
      }).toList(),
    );

  }




  Widget buildCategoriasList() {

    final PageViewController pageController = Get.find<PageViewController>();

    return ListView.builder(
      itemCount: pageController.categoriasProdutos.length,
      itemBuilder: (context, index) {
        return buildCategoriaCard(pageController.categoriasProdutos[index]);
      },
    );
  }

  Widget buildCategoriaCard(CategoriaModel categoria) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            categoria.iconPath, // Ícone da categoria
            SizedBox(width: 10), // Espaço entre o ícone e o texto
            Text(categoria.nome), // Nome da categoria
          ],
        ),
      ),
      color: categoria.boxColor, // Cor de fundo do card
    );
  }



}