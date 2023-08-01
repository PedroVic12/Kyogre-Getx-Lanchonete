import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Barra%20Inferior/BarraInferior.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/BotoesIcone.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CarrinhoController.dart';


// https://www.youtube.com/watch?v=S_LZiS5VNKA -> 1:13 Carrinho layout

class Carrinho extends StatelessWidget {
  final CarrinhoController controller = Get.find();

  Carrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Obx(() => SizedBox(
            height: 550,
            child: ListView.builder(
              itemCount: controller.produtosCarrinho.length,
              itemBuilder: (BuildContext context, int index) {
                final produto = controller.produtosCarrinho.keys.toList()[index];
                final quantidade = controller.produtosCarrinho[produto] ?? 0;

                return CarrinhoCard(
                  controller: controller,
                  produto: produto,
                  quantidade: quantidade,
                  index: index,
                );
              },
            ),
          )),
          BarraInferiorWidget(totalCarrinho: controller.totalCarrinho)


        ],
      )
    );
  }
}


class CarrinhoCard extends StatelessWidget {
  final CarrinhoController controller;
  final Produto produto;
  final int quantidade;
  final int index;

   CarrinhoCard({
    Key? key,
    required this.controller,
    required this.produto,
    required this.quantidade,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(7),child: Container(
      padding: EdgeInsets.all(20),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(produto.imageUrl),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              produto.nome,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              produto.preco.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BotoesIcone(
            onPressed: () {
              controller.removerProduto(produto);
            },
            cor: Colors.black,
            iconData: CupertinoIcons.minus_circle_fill,
          ),
          CustomText(text: "$quantidade", size: 18),
          BotoesIcone(
            onPressed: () {
              controller.adicionarProduto(produto);
            },
            cor: Colors.black,
            iconData: CupertinoIcons.plus_circle_fill,
          )
        ],
      ),
    ),);
  }
}



