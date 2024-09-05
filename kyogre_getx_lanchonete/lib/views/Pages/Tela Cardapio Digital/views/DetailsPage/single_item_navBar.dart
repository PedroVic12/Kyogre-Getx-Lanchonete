import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/template/produtos_model.dart';

import '../../../Carrinho/controller/sacola_controller.dart';

class SingleItemNavBar extends StatelessWidget {
  final ProdutoModel produto;
  SingleItemNavBar({super.key, required this.produto});
  final CarrinhoPedidoController carrinho =
      Get.find<CarrinhoPedidoController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CustomText(
                  text: 'Total: R\$ ${carrinho.totalPrice.toStringAsFixed(2)}',
                  size: 18,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                btnQuantidade()
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          BotaoCarrinho2(produto: produto),
        ],
      ),
    );
  }

  Widget btnQuantidade() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            carrinho.removerProduto(produto);
          },
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: const Icon(CupertinoIcons.minus_circle_fill, size: 32),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Obx(() {
          final quantidade = carrinho.SACOLA[produto] ?? 0;
          return CustomText(
            text: ' $quantidade',
            size: 28,
            color: Colors.red,
            weight: FontWeight.bold,
          );
        }),
        const SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {
            carrinho.adicionarCarrinho(produto);
          },
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              CupertinoIcons.plus_circle_fill,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}

class BotaoCarrinho2 extends StatelessWidget {
  final ProdutoModel produto;
  final CarrinhoPedidoController carrinho =
      Get.find<CarrinhoPedidoController>();

  BotaoCarrinho2({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: TextButton(
                onPressed: () {
                  carrinho.adicionarCarrinho(produto);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Adicionar no Carrinho',
                      size: 24,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ))));
  }
}
