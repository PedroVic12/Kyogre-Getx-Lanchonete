import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Barra%20Inferior/BarraInferior.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/views/CarrinhoCard.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';

import '../../../app/widgets/Barra Inferior/modal_pedido_wpp.dart';

class CarrinhoPage extends StatelessWidget {

  final CarrinhoPedidoController carrinho = Get.put(CarrinhoPedidoController());

  CarrinhoPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🛒 CARRINHO '),
      ),

      body: Obx(() {
        if (carrinho.SACOLA.isEmpty) {
          return const Center(
            child:  CustomText(text: 'Você não tem nenhum produto na sacola ainda', size: 25),
          );
        } else {
          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  itemCount: carrinho.SACOLA.length,
                  itemBuilder: (BuildContext context, int index) {
                    final produto = carrinho.SACOLA.keys.toList()[index];
                    final quantidade = carrinho.SACOLA[produto] ?? 0;

                    return CardCarrinho(
                      carrinhoController: carrinho,
                      produto: produto,
                      quantidade: quantidade,
                    );
                  },
                ),
              ),



              BarraInferiorPedido(),
            ],
          );
        }
      }),
    );
  }
}
