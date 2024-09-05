import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Produto {
  final String nome;
  final String iconPath;

  Produto({required this.nome, required this.iconPath});
}

class MenuCardapioProdutosController extends GetxController {
  final List<Produto> _categorias = [];
  final List<Produto> _produtos = [];
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void trocarItemSelecionado(int index) {
    _selectedIndex = index;
  }

  void addProduto(Produto produto) {
    _produtos.add(produto);
  }

  List<Produto> fetchCategorias() {
    // Retorne a lista de categorias aqui.
    // Você pode substituir isso com sua própria implementação.
    return [
      Produto(nome: 'Pizza', iconPath: 'assets/icons/pizza.png'),
      Produto(nome: 'Burguer', iconPath: 'assets/icons/burger.png'),
      Produto(nome: 'Bebidas', iconPath: 'assets/icons/drink.png'),
    ];
  }
}
