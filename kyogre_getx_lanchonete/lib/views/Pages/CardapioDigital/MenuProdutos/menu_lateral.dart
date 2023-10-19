


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';

import '../../../../app/widgets/Custom/CustomText.dart';

class MenuLateralCategoriasProdutos extends StatelessWidget {
  final MenuProdutosController menuController = Get.put(MenuProdutosController());
  List<CategoriaModel> categorias_produtos = [];

  void _getCategorias(){
    categorias_produtos = menuController.getCategorias();
  }

  MenuLateralCategoriasProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    _getCategorias();
    return Container(
      color: Colors.yellow,
      padding: EdgeInsets.all(12),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(text: 'Categorias'),
          SizedBox(height: 15,),
          Container(
            height: 100,
            child: ListView.separated(
                itemCount:categorias_produtos.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
                separatorBuilder: (context,index) => SizedBox(width: 16,),
                itemBuilder: (context,index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: categorias_produtos[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16)
                    ),

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: categorias_produtos[index].iconPath, // passar uma imagem de icone

                          ),

                          SizedBox(height: 8,),

                          CustomText(text: categorias_produtos[index].nome , weight: FontWeight.bold,size: 14,)
                        ]
                    ),
                  );
                }),
          ),

          //ItemDisplay(),
          //SelectedProductDisplay(),
        ],
      ),
    );
  }
}


