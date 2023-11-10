import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/MenuCategoriasScroll.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/cardapio_scroll_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/tab_view_scroll_cardapio.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

import '../../../../../models/DataBaseController/DataBaseController.dart';
import 'controllers/page_view_controller.dart';


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

    pageController.loadTabs();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final produtos = catalogoProdutosController.produtos;

    return Scaffold(
      appBar: AppBar(title: Text('Cardapio Digital 3')),
      body: Column(
        children: [


          MenuCategoriasScrollGradientWidget(
            onCategorySelected: (index) {
              menuController.produtoIndex.value = index;
            },
          ),
          //_buildListViewProdutos(),

          Obx(() => CustomText(text: 'Index = ${menuController.produtoIndex.value}',size: 20,),),

          buildCategoriaCard(
              CategoriaModel(nome: 'Pizza', iconPath: Icon(Icons.add), boxColor: Colors.black12)
          ),


         // Container(  color: Colors.redAccent,    child: const TabViewScrollCardapio1(),    ),


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





  Widget buildCategoriasList() {
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


  Widget _buildListViewProdutos(){
    return
      Container(
        color: Colors.redAccent,
        height: 100, // Defina uma altura adequada
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pageController.myTabs_array.length,
          itemBuilder: (context, index) {
            // Acessando o texto de cada aba
            var tabText = pageController.myTabs_array[index].text;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10), // Espaçamento entre itens
              child: Center(
                child: Text(tabText ?? 'Tab ${index + 1}'), // Texto da aba ou um valor padrão
              ),
            );
          },
        ),
      );


  }
}


