

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
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          color: CupertinoColors.systemGrey2,
          child: content,
        );

      },
      overleafColorBuilder: (index) => index == 0 ? Colors.blue : Colors.green,
      animationTransitionPoint: 0.7,
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
