import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

import '../../../Carrinho/controller/sacola_controller.dart';

class SingleItemNavBar extends StatelessWidget {
  final ProdutoModel produto;
   SingleItemNavBar({super.key, required this.produto});
  final CarrinhoPedidoController carrinho = Get.find<CarrinhoPedidoController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Obx(() =>      Column(
              children: [
                SizedBox(height: 15),
                CustomText(text: 'Total: R\$ ${carrinho.totalPrice.toStringAsFixed(2)}', size: 22, color: Colors.black,),
              ],
            ),),

            BotaoCarrinho2(produto: produto),
          ],
        ),
      );

  }
}


class BotaoCarrinho2 extends StatelessWidget {

  final ProdutoModel produto;
  final CarrinhoPedidoController carrinho = Get.find<CarrinhoPedidoController>();

   BotaoCarrinho2({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Center(child:  Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
        child: TextButton(
            onPressed: () {
              carrinho.adicionarCarrinho(produto);
            },
            child:  Row(
              children: [
                SizedBox(height: 15),
                CustomText(text: 'Adicionar no Carrinho', size: 22, color: Colors.white,),
                SizedBox(height: 10),
                Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ],
            )
        )
    ));
  }
}
