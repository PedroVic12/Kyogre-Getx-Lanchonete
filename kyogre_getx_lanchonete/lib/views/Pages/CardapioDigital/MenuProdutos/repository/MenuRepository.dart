import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

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
    await fetchCategorias();

    if (MenuCategorias_Array.isNotEmpty) {
      MenuCategorias_Array.forEach((element) {
        print(' MENU = ${element.nome}');
      });

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
          nome: 'Sanduiches',
          iconPath: Icon(Icons.fastfood_rounded,),
        ),
        CategoriaModel(
          nome: 'Salgados',
          iconPath: Icon(Icons.local_pizza_rounded),
        ),
        CategoriaModel(
          nome: 'Açai e Pitaya',
          img: Image.asset('lib/repository/icons/acai.jpg',height: 20, width: 20,),
        ),
        CategoriaModel(
          nome: 'Sobremesas',
          img: Image.asset('lib/repository/icons/cake.png',height: 20, width: 20,),
        ),
        CategoriaModel(
          nome: 'Hamburguer',
          iconPath: Icon(Icons.local_drink),
        ),
        CategoriaModel(
          nome: 'Cuscuz de Milho',
          iconPath: Icon(Icons.egg_alt_rounded),
        ),
        CategoriaModel(
          nome: 'Omelete',
          iconPath: Icon(Icons.egg_alt_rounded),
        ),
        CategoriaModel(
          nome: 'Crepe',
          iconPath: Icon(Icons.fastfood_rounded),
        ),
        CategoriaModel(
          nome: 'Tapioca',
          iconPath: Icon(Icons.fastfood_rounded),
        ),
        CategoriaModel(
          nome: 'Cafeteria',
          iconPath: Icon(Icons.coffee),
        ),
        CategoriaModel(
          nome: 'Bebidas',
          img: Image.asset('lib/repository/icons/drink.png',height: 20, width: 20,),
        ),
        CategoriaModel(
          nome: 'Sucos',
          img: Image.asset('lib/repository/icons/cocktail.png',height: 20, width: 20,),
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
