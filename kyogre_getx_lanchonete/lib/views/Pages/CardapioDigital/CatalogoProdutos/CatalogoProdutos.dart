import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosCard.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/MenuCategorias.dart';


class ProdutosList extends StatelessWidget {
  const ProdutosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalogoProdutosController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              controller.categoria,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: controller.produtosFiltrados.length,
              itemBuilder: (context, index) {
                Produto produto = controller.produtosFiltrados[index];
                return Card(
                  child: ListTile(
                    title: Text(produto.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (produto.preco != null) ...[
                          if (produto.preco!.preco1 != null)
                            Text('Preço 1: R\$ ${produto.preco!.preco1}'),
                          if (produto.preco!.preco2 != null)
                            Text('Preço 2: R\$ ${produto.preco!.preco2}'),
                        ],
                        // Adicione mais detalhes sobre o produto aqui
                      ],
                    ),
                    leading: Icon(Icons.fastfood),  // Um ícone para indicar que este é um produto
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),  // Um botão para adicionar o produto ao carrinho
                      onPressed: () {
                        // Adicione o produto ao carrinho aqui
                      },
                    ),
                  ),
                );
              },
            ))
          ],
        );
      },
    );
  }
}



class CatalogoProdutos extends StatelessWidget {
  final catalogoProdutosController = Get.find<CatalogoProdutosController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Menu Com Scroll para selecionar os produtos
          MenuCategorias(
            categorias: catalogoProdutosController.categorias,
            onCategorySelected: (index) {
              catalogoProdutosController.setCategoria(catalogoProdutosController.categorias[index]);
              print('\n\nCategoria selecionada: ${catalogoProdutosController.categorias[index]}');
            },
          ),

          // Catalogo de Produtos
          ProdutosList(),
        ],
      ),
    );
  }
}
