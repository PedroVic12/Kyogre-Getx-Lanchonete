// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosCard.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/MenuCategorias.dart';



class CatalogoProdutos extends StatelessWidget {
  final catalogoProdutosController = Get.find<CatalogoProdutosController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [


          MenuCategorias(
            categorias: catalogoProdutosController.Catalogocategorias,
            onCategorySelected: (index) {
              catalogoProdutosController.setCategoria(catalogoProdutosController.Catalogocategorias[index]);
              print('\n\nCategoria selecionada: ${catalogoProdutosController.Catalogocategorias[index]}');
            },
          ),

          CatalogoProdutosCard(),
        ],
      ),
    );
  }
}
