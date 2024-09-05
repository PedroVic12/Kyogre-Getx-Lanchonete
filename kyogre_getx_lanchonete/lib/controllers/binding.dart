import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/repository_db_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';

class GlobalBindings extends Bindings {
  final List _nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

  @override
  void dependencies() async {
    // Dependências globais comuns (se houver)

    setUpCardapioDigital();
  }

  void setUpCardapioDigital() async {
    Get.put(MenuController());
    Get.put(RepositoryDataBaseController());
    Get.put(CarrinhoController());
    Get.put(MenuProdutosRepository());
    Get.put(MenuProdutosController());
  }

  void bindOutraPagina() {
    // Outras dependências específicas para OutraPagina
  }
}
