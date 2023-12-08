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
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Obx(() =>      Column(

              children: [
                SizedBox(height: 15,),
                CustomText(text: 'Total: R\$ ${carrinho.totalPrice.toStringAsFixed(2)}', size: 18, color: Colors.black,),

              ],
            ),),
            SizedBox(width: 15,),
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
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
        child: TextButton(
            onPressed: () {
              carrinho.adicionarCarrinho(produto);
            },
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'Adicionar no Carrinho', size: 20, color: Colors.white,),
                Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            )
        )
    ));
  }
}
