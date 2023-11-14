

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

import '../../../../../../app/widgets/Custom/CustomText.dart';
import '../../produtos_controller.dart';
class FolearCardapioDigital extends StatelessWidget {
  final Widget content;
  final Function(int) onPageChanged;

  FolearCardapioDigital({
    Key? key,
    required this.content,
    required this.onPageChanged,
  }) : super(key: key);

  final menuController = Get.find<MenuProdutosController>();

  @override
  Widget build(BuildContext context) {
    final controller = TurnPageController();
    controller.addListener(() {
      onPageChanged(controller.animateToPage(menuController.produtoIndex.value) as int);
    });

    return TurnPageView.builder(
      controller: controller,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          height: 120,
          color: CupertinoColors.systemCyan,
          child: content,
        );
      },
      overleafColorBuilder: (index) => index == 0 ? Colors.blue : Colors.green,
      animationTransitionPoint: 0.7,
    );
  }

  Widget displayProdutos(int index) {
    final menuController = Get.find<MenuProdutosController>();
    var produto = menuController.categoriasProdutosMenu[index];

    return Center(
      child: Text(
        'Produto: ${produto.nome}',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }


  Widget _indexProdutoSelecionado(){

    final MenuProdutosController menuController = Get.find<MenuProdutosController>();

    return Container(
        color: Colors.black,
        child: Obx(() => Center(child: Column(children: [
          CustomText(text: 'item selecionado = ${menuController.produtoIndex}',color: Colors.white,),
          CustomText(text: 'item selecionado = ${menuController.categoriasProdutosMenu[menuController.produtoIndex.value].nome}',color: Colors.white,),
        ],))));
  }
}
