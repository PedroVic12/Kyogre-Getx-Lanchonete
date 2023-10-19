
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';

import '../CatalogoProdutos/CatalogoProdutosController.dart';







class MenuProdutosController extends GetxController {
  final CatalogoProdutosController catalogoController = Get.put(CatalogoProdutosController());

  // Usaremos uma variável observável para controlar a categoria selecionada
  var produtoIndex = 0.obs;

  // Obtém as categorias do controlador de catálogo de produtos
  List get categorias => catalogoController.Catalogocategorias;

  // Obtém a categoria selecionada
  CategoriaModel get categoriaSelecionada =>
      categorias.isNotEmpty ? categorias[produtoIndex.value] : CategoriaModel(
        nome: 'Nenhuma categoria selecionada',
        iconPath: Icon(Icons.error_outline),
        boxColor: Colors.red,
      );

  // Atualiza o produto selecionado com base no índice
  void atualizarProdutoSelecionado(int index) {
    if (index >= 0 && index < categorias.length) {
      produtoIndex.value = index;
    }
  }
}
