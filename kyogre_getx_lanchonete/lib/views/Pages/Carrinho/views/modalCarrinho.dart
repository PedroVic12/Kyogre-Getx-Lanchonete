import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/Barra Inferior/BarraInferior.dart';
import '../../../../app/widgets/Barra Inferior/modal_pedido_wpp.dart';

class BottomSheetWidget extends StatelessWidget {
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  final String nomeCliente;
  final String telefoneCliente;
  final String id;

  BottomSheetWidget({
    required this.nomeCliente,
    required this.telefoneCliente,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: DraggableScrollableSheet(
          initialChildSize: 0.5, // Tamanho inicial mínimo da BottomSheet
          minChildSize: 0.3, // Tamanho mínimo (quando fechado)
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return Container(
              child: Column(
                children: [

                  barraLateral(),

                  BotaoNavegacao1(),

                  BarraInferiorPedido(),

                ],
              ),
            );
          },
        ),
      ),
    );
  }


  Widget barraLateral(){
    return
      Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(child: CustomText(text: 'Ola mundo',color: Colors.white),)
      );
  }


  Widget BotaoNavegacao1(){
    return  Padding(
      padding: EdgeInsets.all(12),
      child: SizedBox(
        height: 50,
        width: 200,
        child: ElevatedButton(
            onPressed: () {
              carrinhoController.setClienteDetails(
                  nomeCliente, telefoneCliente, id);
              Get.to(CarrinhoPage(),
                  arguments: [nomeCliente, telefoneCliente, id]);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CupertinoColors.activeBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),


            child: Row(children: [Icon(Icons.shopify_rounded),  CustomText(text: 'CLIQUE AQUI',color: Colors.white,)],)
        ),
      ),
    );
  }

}
