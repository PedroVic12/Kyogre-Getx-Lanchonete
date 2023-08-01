import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomCard.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CarrinhoController.dart';

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
    final produto = Produto.produtos_loja[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Define o raio dos cantos
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(produto.imageUrl),
                backgroundColor: Colors.blue,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${produto.preco}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  cartController.adicionarProduto(produto);
                },
                icon: Icon(CupertinoIcons.plus_app_fill, size: 30,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
