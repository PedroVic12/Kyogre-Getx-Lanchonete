import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';

class MenuProdutosRepository extends GetxController{
  final List<CategoriaModel> MenuCategorias_Array = [];
  
  //define oc carregamneto
  var isLoading = true.obs;

  Future getCategoriasRepository() async {
    isLoading.value = true;
    await fetchCategorias();

    if (MenuCategorias_Array.isNotEmpty){
      MenuCategorias_Array.forEach((element) {
        print('Categoria = ${element.nome}');
      });

      isLoading.value = false;
    }

    update();
    return isLoading;
  }
  
  
  List<CategoriaModel> fetchCategorias()  {

    MenuCategorias_Array.clear();

    if (MenuCategorias_Array.isEmpty) {
      // Adicione itens apenas se a lista estiver vazia para evitar duplicatas
      MenuCategorias_Array.addAll([

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
    return MenuCategorias_Array;
  }
}
