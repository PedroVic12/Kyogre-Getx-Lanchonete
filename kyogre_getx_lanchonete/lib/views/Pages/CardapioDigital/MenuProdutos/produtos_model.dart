

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/Custom/CustomText.dart';
import '../CatalogoProdutos/CatalogoProdutosController.dart';

class CategoriaModel {
  String nome;
  Icon iconPath;
  Color boxColor;

  CategoriaModel({required this.nome, required this.iconPath, required this.boxColor});

}


class MenuProdutosController extends GetxController {
  final CatalogoProdutosController catalogoController = Get.put(CatalogoProdutosController());


  var produtoIndex = -1; // Inicialmente nenhum produto selecionado
  List<CategoriaModel> categorias_produtos = [];

  // Carregamento
  bool _isLoading = true; // Defina como true para indicar que está carregando.

  @override
  void onInit() {
    super.onInit();
    _getCategorias();
  }

  void _getCategorias() {
    categorias_produtos = getCategorias();
    _isLoading = false;
    update(); // Atualiza a UI após o carregamento
  }



  List<CategoriaModel> categorias = [];

   List<CategoriaModel> getCategorias(){


    categorias.add(
        CategoriaModel(nome: 'Sanduiches', iconPath: Icon(Icons.fastfood_rounded), boxColor: Colors.purple.shade300)
    );

    categorias.add(
        CategoriaModel(nome: 'Petiscos', iconPath: Icon(Icons.fastfood_rounded), boxColor: Colors.purple.shade300)
    );

    categorias.add(
        CategoriaModel(nome: 'Açai e Pitaya', iconPath: Icon(Icons.fastfood_rounded), boxColor: Colors.purple.shade300)
    );

    categorias.add(
        CategoriaModel(nome: 'salada', iconPath: Icon(Icons.fastfood_rounded), boxColor: Colors.purple.shade100)
    );

    categorias.add(
        CategoriaModel(nome: 'Hamburguer', iconPath: Icon(Icons.fastfood_rounded), boxColor: Colors.purple.shade200)
    );

    categorias.add(
        CategoriaModel(nome: 'Pizza', iconPath: Icon(Icons.fastfood_rounded), boxColor: Colors.purple.shade300)
    );



    return categorias;
  }




  // Obtém as categorias do controlador de catálogo de produtos
  List get categoriasCatalogoProdutos => catalogoController.Catalogocategorias;


  // Atualiza o produto selecionado com base no índice
  void atualizarProdutoSelecionado(int index) {
    if (index >= 0 && index < categoriasCatalogoProdutos.length) {
      produtoIndex = index;
    }
  }
}


class ProdutosDetails extends StatelessWidget {
  String nome;
  Icon imagem_produto;

  ProdutosDetails({super.key, required this.nome, required this.imagem_produto});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: CircleAvatar(child: imagem_produto,),
          height: 60,
          width: 60,
        ),
        SizedBox(height: 12,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CustomText(text:nome , size: 15, weight: FontWeight.bold,),
        ),
      ],
    );
  }
}


