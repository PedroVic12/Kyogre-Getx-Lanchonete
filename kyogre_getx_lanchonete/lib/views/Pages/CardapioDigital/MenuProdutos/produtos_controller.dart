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
  final CatalogoProdutosController catalogoController = Get.put(CatalogoProdutosController());
  final MenuProdutosRepository repository = MenuProdutosRepository(); // Usando o repository

  //variaveis
  List<CategoriaModel> categorias_produtos_carregados = []; // metodo pardrao
  List<CategoriaModel> categoriasProdutosMenu = []; // pegando os produtos do databse


  var produtos = <CategoriaModel>[].obs;
  var produtoIndex = 0.obs;
  //var produtosWidgets = <Widget>[].obs;
  var isLoading = true.obs;

  //metodos
  void setProdutoIndex(int index) {
    produtoIndex.value = index;
    update(); // Notifica os ouvintes de que o estado foi atualizado
    print('Produto atualizado!');
  }


  trocarItemSelecionado(int novoProdutoIndex) {

    produtoIndex.value = novoProdutoIndex;
    int categoriaSelecionadaIndex = catalogoController.catalogoCategorias
        .indexOf(categorias_produtos_carregados[novoProdutoIndex].nome);
    catalogoController.setCategoria(categoriaSelecionadaIndex);
  }


  Future getCategoriasRepository() async {
    categoriasProdutosMenu = await repository.fetchCategorias();
    isLoading.value = false;
    return categoriasProdutosMenu;
  }

  @override
  void onInit() {
    super.onInit();
    getCategoriasRepository();
  }




  //Pega os Dados do Menu
  List<CategoriaModel> fetchCategorias() {
    categorias_produtos_carregados.clear();

    categorias_produtos_carregados.add(CategoriaModel(
        nome: 'Sanduíches',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categorias_produtos_carregados.add(CategoriaModel(
        nome: 'Petiscos',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    categorias_produtos_carregados.add(CategoriaModel(
        nome: 'Açaí e Pitaya',
        iconPath: Icon(Icons.fastfood_rounded),
        boxColor: Colors.purple.shade300));

    return categorias_produtos_carregados;
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
        const SizedBox(height: 8),
        CircleAvatar(child: imagem_produto),
        const SizedBox(height: 8),
        CustomText(
          text: nome,
          size: 14,
          weight: FontWeight.bold,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
