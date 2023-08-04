import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Barra%20Inferior/BarraInferior.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoCard.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';

class CarrinhoPage extends StatelessWidget {

  final CarrinhoController carrinhoController = Get.put(CarrinhoController());

  CarrinhoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho do Cliente'),
      ),
      body: Obx(() {
        if (carrinhoController.produtosCarrinho.isEmpty) {
          return Center(
            child: Text('Você não tem nenhum produto na sacola ainda'),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: carrinhoController.produtosCarrinho.length,
                  itemBuilder: (BuildContext context, int index) {
                    final produto = carrinhoController.produtosCarrinho.keys.toList()[index];
                    final quantidade = carrinhoController.produtosCarrinho[produto] ?? 0;

                    return CardCarrinho(
                      carrinhoController: carrinhoController,
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
