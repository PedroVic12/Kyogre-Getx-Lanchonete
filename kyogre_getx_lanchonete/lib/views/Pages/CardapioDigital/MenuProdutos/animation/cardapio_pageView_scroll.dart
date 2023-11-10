import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/MenuCategoriasScroll.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/cardapio_scroll_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

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



          Obx(() => CustomText(text: 'Index = ${menuController.produtoIndex.value}'),),

          Container(
            color: Colors.redAccent,
            child: ListView.builder(itemCount: pageController.myTabs_array.length,itemBuilder: (context, index) {
              return Column(
                children: [
                  CustomText(text: pageController.myTabs_array.length.toString(),),
                  CustomText(text: '${pageController.myTabs_array[index]}')  
                ],
              );
            }),
          ),
          
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


