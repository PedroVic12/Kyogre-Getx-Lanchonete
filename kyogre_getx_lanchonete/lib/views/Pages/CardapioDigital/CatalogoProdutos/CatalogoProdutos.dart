import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CarrinhoController.dart';

//TODO 12 TUTORIAL

class CatalogoProdutos extends StatelessWidget {
  const CatalogoProdutos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.builder(
            itemCount: Produto.produtos_loja.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  CatalogoProdutosCard(index: index),

                ],
              );
            }));
  }
}

class CatalogoProdutosCard extends StatelessWidget {
  final int index;
  final cartController = Get.put(CarrinhoController());

  CatalogoProdutosCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(Produto.produtos_loja[index].imageUrl),
              backgroundColor: Colors.blue,
            ),
            SizedBox(width: 20),
            Expanded(
                child: Text(
              Produto.produtos_loja[index].nome,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            Expanded(child: Text('${Produto.produtos_loja[index].preco}')),
            IconButton(onPressed: () {
              cartController.adicionarProduto(Produto.produtos_loja[index]);

            }, icon: Icon(Icons.add_circle_rounded)),



          ],
        ));
  }
}
