//Controller
// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';

import 'repository/produtos_model.dart';

class MenuProdutosController extends GetxController {


  var produtos = <CategoriaModel>[].obs;
  var produtoIndex = 0.obs;


  //metodos
  void setProdutoIndex(int index) {
    produtoIndex.value = index;
    update(); // Notifica os ouvintes de que o estado foi atualizado
    print('Produto atualizado!');
  }



  @override
  void onInit() {
    super.onInit();
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
