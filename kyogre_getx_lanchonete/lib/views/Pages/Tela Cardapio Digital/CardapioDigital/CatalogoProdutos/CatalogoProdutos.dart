// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CatalogoProdutos/CatalogoProdutosCard.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CatalogoProdutos/MenuCategorias.dart';

class CatalogoProdutos extends StatelessWidget {
  final catalogoProdutosController = Get.find<CatalogoProdutosController>();

  CatalogoProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MenuCategorias(
            categorias: catalogoProdutosController.catalogoCategorias,
            onCategorySelected: (index) {
              catalogoProdutosController.setCategoria(
                  catalogoProdutosController.catalogoCategorias[index] as int);
              print(
                  '\n\nCategoria selecionada: ${catalogoProdutosController.catalogoCategorias[index]}');
            },
          ),
          CatalogoProdutosCard(),
        ],
      ),
    );
  }
}
