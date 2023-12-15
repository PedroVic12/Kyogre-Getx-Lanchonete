import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/BotaoPadrao.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/themes%20/cores.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';

import '../../../views/Pages/Carrinho/CarrinhoPage.dart';
import '../../../views/Pages/Carrinho/controller/backend_wpp.dart';
import '../../../views/Pages/Tela Cardapio Digital/controllers/cardapio_controller.dart';


class ModalInferior extends StatelessWidget {
   ModalInferior({super.key});
  final CarrinhoPedidoController carrinho = Get.put(CarrinhoPedidoController());
  final GroundonBackEndController Groundon = Get.put(GroundonBackEndController());

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration:  BoxDecoration(
            color: Colors.blueGrey.shade200,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(50)
            ),
            boxShadow:[
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 2
              )
            ]
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child:    Obx(
                  ()=> Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10,),
                          CustomText(text: 'Total: R\$ ${carrinho.totalPrice.toStringAsFixed(2)}', size: 20),
                          CustomText(text: 'Itens no carrinho ${carrinho.SACOLA.length}'),
                        ],
                      ),
                      BotaoNavegacao1(),
                    ],
                  ),
                )
              )
          ),
        )
    );
  }


   Widget BotaoNavegacao1() {
     return BotaoPadrao(color:  CupertinoColors.activeBlue,on_pressed: (){
       Get.to(()=> CarrinhoPage());
     },
         child: Center(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Icon(
                 Icons.shopping_cart_checkout_rounded,
                 size: 22,
                 color: Colors.white,
               ),
               CustomText(
                 text: 'VER CARRINHO',
                 color: Colors.white,
                 size: 18,
               )
             ],
           ),
         ));


   }

}

