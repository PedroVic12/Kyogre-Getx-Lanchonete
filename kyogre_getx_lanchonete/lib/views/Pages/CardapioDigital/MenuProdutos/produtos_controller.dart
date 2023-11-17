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
  final MenuProdutosRepository repository = Get.put(MenuProdutosRepository()); // Usando o repository

  //variaveis
  List<CategoriaModel> categoriasProdutosMenu = []; // pegando os produtos do databse

  var produtos = <CategoriaModel>[].obs;
  var produtoIndex = 0.obs;
  //var produtosWidgets = <Widget>[].obs;
  var isLoading = false.obs;

  //metodos
  void setProdutoIndex(int index) {
    produtoIndex.value = index;
    update(); // Notifica os ouvintes de que o estado foi atualizado
    print('Produto atualizado!');
  }


  Future getCategoriasRepository() async {
    isLoading.value = true;
    categoriasProdutosMenu = await repository.fetchCategorias();
    isLoading.value = false;
  }


  Future initPage() async {
    if (isLoading.value){
      print('Carregou!');
    } else {
      print('\nainda carregando......');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCategoriasRepository();
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
