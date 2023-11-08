import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';




class DisplayCardItensCardapio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MenuProdutosController menuController = Get.put(MenuProdutosController()); // Encontre o controller já existente


    return Obx(() { // Observe mudanças no índice do produto
      final categoriaProduto = menuController.categorias_produtos_carregados[menuController.produtoIndex.value]; // Use o índice observável para obter o produto atual

      return Column(
      children: [

      Container(
        color: Colors.white,
        child: cardDisplayProdutos(),
      ),

        Container(
          color: Colors.blue,
          child: cardProduto(),
        ),

        Container(
          color: Colors.red,
          child: Text('ola mundo'),
        )
      ],
      );
    });
  }

  Widget cardDisplayProdutos(){
    final MenuProdutosController menuController = Get.put(MenuProdutosController()); // Encontre o controller já existente

    final categoriaProduto = menuController.categorias_produtos_carregados[menuController.produtoIndex.value]; // Use o índice observável para obter o produto atual

    return Card(
      child: CupertinoListTile(
        title: Text('Selecionado = ${categoriaProduto.nome}'),
        trailing: Text('Índice = ${menuController.produtoIndex}'),
      ),
    );
  }

  Widget pageView() {

    final CatalogoProdutosController catalogoProdutosController = Get.put(CatalogoProdutosController());
    final PageController pageController = PageController(); // Controlador para o PageView

    return PageView(
      controller: pageController, // Use o controlador aqui
      children: catalogoProdutosController.categorias.map((categoria) {
        // Mapeie cada categoria para um widget
        return Center(
          child: Card(
            child: ListTile(
              title: Text(categoria.nome),
              // Você pode adicionar mais detalhes do produto aqui
            ),
          ),
        );
      }).toList(),
    );
  }

  // Widget privado para o PageView
  Widget _ProdutoPageView({required List<Produto> produtos}) {
    return PageView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        final produto = produtos[index];
        return _buildProdutoPage(produto);
      },
    );
  }

  // Método para construir a página do produto
  Widget _buildProdutoPage(Produto produto) {
    return Center(
      child: Card(
        child: ListTile(
          title: Text(produto.nome),
        ),
      ),
    );
  }




















  Widget cardProduto(){

    final CarrinhoController carrinhoController = Get.put(CarrinhoController());
    final catalogoProdutosController = Get.put(CatalogoProdutosController());
    var produtos = catalogoProdutosController.produtos;


    return  Obx(() => ListView.builder(
      shrinkWrap: true,
      physics:
      BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto produto = produtos[index];
        return Card(
          margin: EdgeInsets.only(
              bottom: 20),
          color: Colors
              .blueGrey.shade100,
          child: ListTile(
            title: CustomText(
              text: produto.nome,
              size: 20,
            ),
            subtitle: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                if (produto.preco !=
                    null) ...[
                  if (produto.preco!
                      .preco1 !=
                      null)
                    CustomText(
                      text:
                      'R\$ ${produto.preco!.preco1}',
                      color: Colors
                          .green,
                      weight:
                      FontWeight
                          .bold,
                      size: 18,
                    ),
                  if (produto.preco!
                      .preco2 !=
                      null)
                    Text(
                        'Preço 2: R\$ ${produto.preco!.preco2}'),
                ],
                // Adicione mais detalhes sobre o produto aqui
              ],
            ),
            leading: Icon(Icons
                .fastfood), // Um ícone para indicar que este é um produto
            trailing: IconButton(
              icon: Icon(
                  Icons.add_box_sharp,
                  color: Colors.blue,
                  size:
                  36), // Um botão para adicionar o produto ao carrinho
              onPressed: () {
                carrinhoController
                    .adicionarProduto(
                    produto);
              },
            ),
          ),
        );
      },
    ));
  }
}
