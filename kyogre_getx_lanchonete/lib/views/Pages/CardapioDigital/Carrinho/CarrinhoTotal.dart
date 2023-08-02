import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CarrinhoController.dart';

class CarrinhoTotal extends StatelessWidget {
 
  final CarrinhoController controller = Get.find();
 
  CarrinhoTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Container(
      padding: EdgeInsets.symmetric(horizontal: 75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total:', style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.bold
          )),
           Text('R${controller.total}', style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.bold
          )),

        ],
      ),
    )
    );
  }
}