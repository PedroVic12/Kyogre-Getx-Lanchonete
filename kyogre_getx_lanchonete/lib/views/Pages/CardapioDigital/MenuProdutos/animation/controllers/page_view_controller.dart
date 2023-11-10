
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../produtos_controller.dart';

class PageViewController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  var myTabs_array = <Tab>[].obs;
  final MenuProdutosController menuController = Get.find<MenuProdutosController>();
  late final categoriasProdutos;


  @override
  void onInit() {
    super.onInit();
    loadTabs();
  }

  void showCustomSnackbar(String title, String message) {
    Get.snackbar(
      title,  // Título da Snackbar
      message,  // Mensagem da Snackbar
      snackPosition: SnackPosition.BOTTOM, // Posição da Snackbar
      duration: Duration(seconds: 3), // Duração da exibição
      backgroundColor: Colors.blue, // Cor de fundo
      colorText: Colors.white, // Cor do texto
    );
  }

  void cout(msg){
    print('\n\n======================================================');
    print(msg);
    print('======================================================');

  }

  Future<void> loadTabs() async {
    // Obtenha as categorias de produtos
    categoriasProdutos = await menuController.fetchCategorias();


    cout('Produtos = ${categoriasProdutos.length}');
    cout(categoriasProdutos);
    showCustomSnackbar('Produtos', '${categoriasProdutos.lengt}');

    // Limpa a lista de abas para evitar duplicatas
    myTabs_array.clear();

    // Cria as abas baseadas nas categorias de produtos
    myTabs_array.addAll(categoriasProdutos.map((categoria) => Tab(text: categoria.nome)).toList());

    // Inclui outras abas que são fixas
    myTabs_array.addAll([
      Tab(text: 'Status'),
      Tab(text: 'Calls'),
    ]);


    // Inicializa o TabController com o número correto de abas
    tabController = TabController(vsync: this, length: myTabs_array.length);



    print(myTabs_array);

    // Exibe uma Snackbar com o número de produtos
    Get.snackbar(
      'Produtos Carregados', // Título da Snackbar
      'Array = ${myTabs_array.length}',
      snackPosition: SnackPosition.BOTTOM, // Posição da Snackbar na tela
    );

  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

