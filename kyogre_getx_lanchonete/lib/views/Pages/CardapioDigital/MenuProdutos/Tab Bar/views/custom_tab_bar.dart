import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';

import '../../../../../../app/widgets/Custom/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/produtos_model.dart';

class TabBarScrollCardapioController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;

  final MenuProdutosController menuController = Get.put(MenuProdutosController());

  //variaveis
  late List<CategoriaModel> categoriasProdutos;


  final List<String> items = [
    'Produto 1',
    'Produto 2',
    'Produto 3',
    'Produto 4',
    'Produto 5',
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: items.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}



class TabBarScrollCardapioWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabBarScrollCardapioController());

    return Column(
      children: [
      barraNavegacao(),


        displayTabBarView()

      ],
    );
  }

  Widget barraNavegacao (){

    final TabBarScrollCardapioController controller = Get.find<TabBarScrollCardapioController>();

    return TabBar(
      controller: controller.tabController,
      tabs: controller.items.map((item) => Tab(text: item)).toList(),
    );
  }

  Widget displayTabBarView(){

    final TabBarScrollCardapioController controller = Get.find<TabBarScrollCardapioController>();

    return TabBarView(
      controller: controller.tabController,
      children: controller.items.map((item) {
        return Center(child: Card(color: Colors.blueGrey.shade300,child: Text(item),));
      }).toList(),
    );
  }
}