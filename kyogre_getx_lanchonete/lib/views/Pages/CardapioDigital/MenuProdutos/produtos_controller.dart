//Controller
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';

import 'produtos_model.dart';

class MenuProdutosController extends GetxController {
  final CatalogoProdutosController catalogoController =
  Get.put(CatalogoProdutosController());

  List<CategoriaModel> categorias_produtos_carregados = [];
  List<CategoriaModel> categorias = [];
  var produtos = <CategoriaModel>[].obs;
  var produtoIndex = 0.obs;
  var produtosWidgets = <Widget>[].obs;

  // Carregamento
  var isLoading = true.obs; // Para rastrear o estado de carregamento.

  // Obtém as categorias do controlador de catálogo de produtos
  List get categoriasCatalogoProdutos => catalogoController.catalogoCategorias;


  @override
  void onInit() {
    super.onInit();
    getCategorias();
  }

  void getCategorias() {
    categorias_produtos_carregados = fetchCategorias();
    isLoading.value = false;
    produtoIndex.value = 0; // Definir "Sanduíche" como selecionado.
    trocarItemSelecionado(
        0); // Isso garante que o produto seja selecionado corretamente ao iniciar
    update();
  }

  //Pega os Dados do Menu
  List<CategoriaModel> fetchCategorias() {
    categorias.add(CategoriaModel(
        nome: 'Sanduíches',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categorias.add(CategoriaModel(
        nome: 'Petiscos',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categorias.add(CategoriaModel(
        nome: 'Açaí e Pitaya',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categorias.add(CategoriaModel(
        nome: 'Salada',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade100));

    categorias.add(CategoriaModel(
        nome: 'Pizza',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    return categorias;
  }

  bool isLeftToRight = true; // Adicione esta variável

  trocarItemSelecionado(int novoProdutoIndex) {

    produtoIndex.value = novoProdutoIndex;
    int categoriaSelecionadaIndex = catalogoController.catalogoCategorias
        .indexOf(categorias_produtos_carregados[novoProdutoIndex].nome);
    catalogoController.setCategoria(categoriaSelecionadaIndex);
  }
}

class ProdutosDetails extends StatelessWidget {
  String nome;
  Icon imagem_produto;

  ProdutosDetails(
      {super.key, required this.nome, required this.imagem_produto});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: CircleAvatar(
            child: imagem_produto,
          ),
          height: 50,
          width:50,
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CustomText(
            text: nome,
            size: 14,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}