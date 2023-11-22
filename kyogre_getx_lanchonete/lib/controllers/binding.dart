import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/DataBaseController/repository_db_controller.dart';
import '../views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';
import '../views/Pages/Carrinho/CarrinhoController.dart';

class GlobalBindings extends Bindings {

 List _nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

 final List<CategoriaModel> _categoriasCardapioProdutos = [];

 @override
 void dependencies() {
  // Dependências globais comuns (se houver)

  setUpCardapioDigital();

 }

 void setUpCardapioDigital() {
  Get.put(MenuController());
  Get.put(RepositoryDataBaseController());
  Get.put(CarrinhoController());
  // Outras dependências específicas para CardapioDigital
 }

 void bindOutraPagina() {
  // Outras dependências específicas para OutraPagina
 }

}
