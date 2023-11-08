//Controller
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';

import 'repository/produtos_model.dart';

class MenuProdutosController extends GetxController {
  //controladores
  final CatalogoProdutosController catalogoController =
  Get.put(CatalogoProdutosController());
  final MenuProdutosRepository repository = MenuProdutosRepository(); // Usando o repository

  //variaveis
  List<CategoriaModel> categorias_produtos_carregados = [];
  List<CategoriaModel> categoriasProdutosMenu = [];
  var produtos = <CategoriaModel>[].obs;
  var produtoIndex = 0.obs;
  var produtosWidgets = <Widget>[].obs;
  var isLoading = true.obs;

  //metodos
  void setProdutoIndex(int index) {
    produtoIndex.value = index;
  }
  void getCategoriasRepository() {
    categoriasProdutosMenu = repository.fetchCategorias();
    isLoading.value = false;
  }

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


  trocarItemSelecionado(int novoProdutoIndex) {

    produtoIndex.value = novoProdutoIndex;
    int categoriaSelecionadaIndex = catalogoController.catalogoCategorias
        .indexOf(categorias_produtos_carregados[novoProdutoIndex].nome);
    catalogoController.setCategoria(categoriaSelecionadaIndex);
  }

  //Pega os Dados do Menu
  List<CategoriaModel> fetchCategorias() {
    categoriasProdutosMenu.add(CategoriaModel(
        nome: 'Sanduíches',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categoriasProdutosMenu.add(CategoriaModel(
        nome: 'Petiscos',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categoriasProdutosMenu.add(CategoriaModel(
        nome: 'Açaí e Pitaya',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categoriasProdutosMenu.add(CategoriaModel(
        nome: 'Salada',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade100));

    categoriasProdutosMenu.add(CategoriaModel(
        nome: 'Pizza',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    return categoriasProdutosMenu;
  }


}
class ProdutosDetails extends StatelessWidget {
  final String nome;
  final Icon imagem_produto;

  const ProdutosDetails({
    Key? key,
    required this.nome,
    required this.imagem_produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(child: imagem_produto),
        const SizedBox(height: 12),
        CustomText(
          text: nome,
          size: 14,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
