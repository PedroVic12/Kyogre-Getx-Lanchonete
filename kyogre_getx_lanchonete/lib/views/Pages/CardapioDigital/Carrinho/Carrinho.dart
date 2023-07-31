import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CartController.dart';


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
    return Container(
      padding: EdgeInsets.all(20),
      height: 600,
      child: Column(
        children: [
          Container(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            produto.preco.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Icon(Icons.disabled_by_default,
                                  color: Colors.green, size: 30),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Icon(CupertinoIcons.minus),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Icon(CupertinoIcons.plus),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
