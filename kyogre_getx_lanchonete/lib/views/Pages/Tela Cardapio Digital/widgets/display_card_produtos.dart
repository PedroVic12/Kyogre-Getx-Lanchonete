import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/float_custom_button.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/DetailsPage/details_page.dart';

import '../../../../app/widgets/Utils/loading_widget.dart';

Widget displayProdutosFiltradosCategoria(String categoria) {
  final CarrinhoPedidoController carrinho =   Get.put(CarrinhoPedidoController());
  final CardapioController cardapioController =  Get.find<CardapioController>();

  var produtosOrdenados = cardapioController.repositoryController.filtrarEOrdenarPorNome(categoria);

  if (produtosOrdenados.isEmpty) {
    return LoadingWidget();
  } else {
    // Exibir a lista de produtos filtrados
    return Expanded(
      child: ListView.builder(
        itemCount: produtosOrdenados.length,
        itemBuilder: (context, index) {
          var produto = produtosOrdenados[index];

          String? pathImg;
          if (produto.imagem != null) {
            List<String>? imagens = produto.imagem?.split('|');
            pathImg = 'lib/repository/assets/FOTOS/${imagens?[0].trim()}';
            cardapioController.pikachu.cout("Img = $pathImg");
          }


          return InkWell(

              onTap: () {
                Get.to(ItemDetailsPage(produto_selecionado: produto,   ));
                //   GetPage(name: '/${produto.nome}', page: ()=> ItemDetailsPage( produto_selecionado: produto));f
              },

              child: Container(
                margin: EdgeInsets.all(6),
                color: Colors.white24,
                height: 100,
                child: Card(
                  elevation: 3,
                  child: Row(
                    children: [
                      //Leading
                      Expanded(flex: 30, child: pathImg != null
                          ? Padding(padding: EdgeInsets.all(6),child:Image.asset(
                        pathImg,
                        fit: BoxFit.fill,
                      ))
                          : Center(child: Icon(Icons.fastfood, size: 32)), ),

                      //Title and Subtitle
                      Expanded(flex: 70,child: Row(
                        children: [
                          Expanded(
                            flex: 25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os filhos na vertical
                              crossAxisAlignment: CrossAxisAlignment.start, // Alinha os filhos ao início na horizontal
                              children: [
                                CustomText(
                                  text: '${produto.nome}',
                                  size: 22,
                                  weight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: 'R\$ ${produto.preco_1} Reais',
                                  size: 16,
                                  color: Colors.green,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),


                          //Trailing
                          Expanded(flex: 10,child: BotaoFloatArredondado(
                              icone: CupertinoIcons.plus_circle_fill,
                              onPress: () {
                                carrinho.adicionarCarrinho(produto);

                                cardapioController.repositoryController.pikachu
                                    .loadDataSuccess('Perfeito', 'Item ${produto.nome} adicionado!');

                              }), )
                        ],
                      ))
                    ],
                  ),
                ),
              )

          );

        },
      ),
    );
  }
}

