import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';

import '../CatalogoProdutos/CatalogoProdutosController.dart';
import '../ItemPage/itemPage.dart';

class DetalhesProdutosCard extends StatefulWidget {
  final Key? key;

  const DetalhesProdutosCard({this.key}) : super(key: key);

  @override
  State<DetalhesProdutosCard> createState() => _DetalhesProdutosCardState();
}

class _DetalhesProdutosCardState extends State<DetalhesProdutosCard> {
  // Controladores
  final MenuProdutosController menuController =
      Get.put(MenuProdutosController());
  final CatalogoProdutosController catalogoProdutosController =
      Get.put(CatalogoProdutosController());
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());

  Future<void> loadProducts() async {
    await Future.delayed(Duration(seconds: 1));
    menuController.isLoading.value = false;
    _productsLoader.complete(); // Complete o completer após o carregamento.
  }

  final _productsLoader = Completer<void>();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding DetalhesProdutosCard");

// Variável para armazenar o nome do produto
    String nomeProduto = '';
    var categoria_selecionada =
        catalogoProdutosController.selectedCategoryIndex.value;
    var categoria = catalogoProdutosController.catalogoCategorias;
    var itemProduto = menuController.categorias_produtos_carregados;
    var produtoSelecionado = itemProduto[menuController.produtoIndex.value];
    var produtos = catalogoProdutosController.produtos;

    // UI
    return FutureBuilder(
      future: _productsLoader.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Obx(() => Container(
                padding: EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: produtos
                        .map(
                          (produto) => GestureDetector(
                              child: Column(
                                children: [
                                  //Obx(() => CustomText(text: itemProduto[menuController.produtoIndex.value].nome,)),  // Obx aqui
                                  //CustomText(text: categoria[menuController.produtoIndex.value]),
                                  //CustomText(text: '${menuController.produtoIndex}'),

                                  


                                  GetBuilder<CatalogoProdutosController>(
                                    builder: (controller) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Obx(() => ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    controller.produtos.length,
                                                itemBuilder: (context, index) {
                                                  Produto produto = controller
                                                      .produtos[index];
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
                                              ))
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                Get.to(ItemPage(),
                                    transition: Transition.leftToRightWithFade);
                              }),
                        )
                        .toList()),
              ));
        }
      },
    );
  }
}
