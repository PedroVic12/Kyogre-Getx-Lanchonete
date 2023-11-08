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
  final CatalogoProdutosController catalogoProdutosController = Get.put(CatalogoProdutosController());
  PageController pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final List<Produto> produtos = [
      Produto('Hamburguer', 'tipo_produto', igredientes: 'igredientes'),
      Produto('Pizza', 'tipo_produto', igredientes: 'igredientes'),
      Produto('Sushi', 'tipo_produto', igredientes: 'igredientes'),
      Produto('Açai', 'tipo_produto', igredientes: 'igredientes')

      // Adicione mais produtos conforme necessário
    ];

    final _controller = MenuProdutosController();

    return Scaffold(
      appBar: AppBar(title: Text('Cardapio Digital')),
      body: Column(
        children: [


          MenuCategoriasScrollGradientWidget(
            onCategorySelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

         Obx(() =>  CustomText(text: 'Index = ${_controller.produtoIndex.value}'),),

          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return Center(
                  child: CustomText(
                    text: "${produtos[index].nome} | Selecionado = $selectedIndex",
                    size: 20,
                  ),
                );
              },
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
