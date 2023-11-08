import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

class MenuProdutosRepository {
  final List<CategoriaModel> categoriasCardapioProdutos = [];

  // Este método simula a busca de dados, que poderia ser de uma API ou banco de dados
  List<CategoriaModel> fetchCategorias() {
    if (categoriasCardapioProdutos.isEmpty) {
      // Adicione itens apenas se a lista estiver vazia para evitar duplicatas
      categoriasCardapioProdutos.addAll([

        CategoriaModel(
            nome: 'Sanduíches',
            iconPath: Icon(Icons.fastfood_rounded),
            boxColor: Colors.purple.shade300),


        CategoriaModel(
        nome: 'Petiscos',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300),

        CategoriaModel(
            nome: 'Açai e Pitaya',
            iconPath: Icon(Icons.fastfood_rounded),
            boxColor: Colors.purple.shade300),

        CategoriaModel(
            nome: 'Pìzzas',
            iconPath: Icon(Icons.fastfood_rounded),
            boxColor: Colors.purple.shade300),

        CategoriaModel(
            nome: 'Hamburguer',
            iconPath: Icon(Icons.fastfood_rounded),
            boxColor: Colors.purple.shade300),
      ]);
    }
    return categoriasCardapioProdutos;
  }
}
