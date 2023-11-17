import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

class MenuProdutosRepository {
  final List<CategoriaModel> categoriasCardapioProdutos = [];

  List<CategoriaModel> fetchCategorias()  {

    categoriasCardapioProdutos.clear();

    if (categoriasCardapioProdutos.isEmpty) {
      // Adicione itens apenas se a lista estiver vazia para evitar duplicatas
      categoriasCardapioProdutos.addAll([

        CategoriaModel(
            nome: 'Sanduiches',
            iconPath: Icon(Icons.fastfood_rounded),
            boxColor: Colors.purple.shade300),


        CategoriaModel(
        nome: 'Petiscos',
        iconPath: Icon(Icons.star),
        boxColor: Colors.purple.shade300),

        CategoriaModel(
            nome: 'Açai e Pitaya',
            iconPath: Icon(Icons.local_drink_sharp),
            boxColor: Colors.purple.shade300),

        CategoriaModel(
            nome: 'Pizzas',
            iconPath: Icon(Icons.local_pizza_rounded),
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
