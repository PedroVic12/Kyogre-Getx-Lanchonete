import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/ItemPage/itemPage.dart';

import '../../../../../controllers/DataBaseController/template/produtos_model.dart';

class CatalogoProdutosCard extends StatelessWidget {
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ItemPage());
      },
      child: GetBuilder<CatalogoProdutosController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.produtos.length,
                    itemBuilder: (context, index) {
                      Produto produto = controller.produtos[index];
                      return Card(
                        child: ListTile(
                          title: CustomText(
                            text: produto.nome,
                            size: 20,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (produto.preco != null) ...[
                                if (produto.preco!.preco1 != null)
                                  CustomText(
                                    text: 'R\$ ${produto.preco!.preco1}',
                                    color: Colors.green,
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                if (produto.preco!.preco2 != null)
                                  Text('Preço 2: R\$ ${produto.preco!.preco2}'),
                              ],
                              // Adicione mais detalhes sobre o produto aqui
                            ],
                          ),
                          leading: Icon(Icons
                              .fastfood), // Um ícone para indicar que este é um produto
                          trailing: IconButton(
                            icon: Icon(Icons.add_box_sharp,
                                color: Colors.blue,
                                size:
                                    30), // Um botão para adicionar o produto ao carrinho
                            onPressed: () {
                              carrinhoController.adicionarProduto(produto);
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
    );
  }
}
