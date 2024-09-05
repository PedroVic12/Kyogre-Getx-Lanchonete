import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'produtos_model.dart';

//MENU DE CATEGORIAS
class MenuProdutosRepository extends GetxController {
  final MenuCategorias_Array = <CategoriaModel>[].obs;

  //define oc carregamneto
  var isLoading = true.obs;
  var produtoIndex = 0.obs;

  //metodos
  void setProdutoIndex(int index) {
    produtoIndex.value = index;
    update(); // Notifica os ouvintes de que o estado foi atualizado
    print('Produto atualizado!');
  }

  Future getCategoriasRepository() async {
    isLoading.value = true;
    fetchCategorias();

    if (MenuCategorias_Array.isNotEmpty) {
      for (var element in MenuCategorias_Array) {
        print(' MENU = ${element.nome}');
      }

      isLoading.value = false;
    }

    update();
    return isLoading;
  }

  List<CategoriaModel> fetchCategorias() {
    MenuCategorias_Array.clear();

    if (MenuCategorias_Array.isEmpty) {
      // Adicione itens apenas se a lista estiver vazia para evitar duplicatas
      MenuCategorias_Array.addAll([
        CategoriaModel(
          nome: 'Sanduíches',
          iconPath: const Icon(
            Icons.fastfood_rounded,
            size: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Salgados',
          iconPath: const Icon(
            Icons.local_pizza_rounded,
            size: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Açai e Pitaya',
          img: Image.asset(
            'lib/repository/icons/acai_bowl.png',
            height: 28,
            width: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Sobremesas',
          img: Image.asset(
            'lib/repository/icons/cake.png',
            height: 28,
            width: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Hamburguer',
          iconPath: const Icon(
            Icons.local_drink,
            size: 28,
          ),
        ),

        //TODO RETIRAR AQUI

        CategoriaModel(
          nome: 'Cuscuz de Milho',
          iconPath: const Icon(
            Icons.egg_alt_rounded,
            size: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Omelete',
          iconPath: const Icon(
            Icons.egg_alt_rounded,
            size: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Crepe',
          iconPath: const Icon(
            Icons.fastfood_rounded,
            size: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Tapioca',
          iconPath: const Icon(
            Icons.fastfood_rounded,
            size: 28,
          ),
        ),

        // PRATOS RÁPIDOS E PRATICOS

        CategoriaModel(
          nome: 'Cafeteria',
          iconPath: const Icon(
            Icons.coffee,
            size: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Bebidas',
          img: Image.asset(
            'lib/repository/icons/drink.png',
            height: 28,
            width: 28,
          ),
        ),
        CategoriaModel(
          nome: 'Sucos',
          img: Image.asset('lib/repository/icons/cocktail.png',
              height: 28, width: 28),
        ),
      ]);
    }
    return MenuCategorias_Array;
  }

  @override
  void onInit() {
    super.onInit();
    getCategoriasRepository();
  }
}
