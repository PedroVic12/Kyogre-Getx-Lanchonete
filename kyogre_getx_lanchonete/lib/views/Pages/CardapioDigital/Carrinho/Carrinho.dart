import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CartController.dart';

class Carrinho extends StatelessWidget {
  final CarrinhoController controller = Get.find();

  Carrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Obx(() => SizedBox(
        height: 600,
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
    );
  }
}

class CarrinhoCard extends StatelessWidget {
  final CarrinhoController controller;
  final Produto produto;
  final int quantidade;
  final int index;

  const CarrinhoCard({
    Key? key,
    required this.controller,
    required this.produto,
    required this.quantidade,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
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
              style: TextStyle(fontSize: 18),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.removerProduto(produto);
            },
            icon: Icon(Icons.remove_circle),
          ),
          Text("$quantidade"),
          IconButton(
            onPressed: () {
              controller.adicionarProduto(produto);
            },
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}
