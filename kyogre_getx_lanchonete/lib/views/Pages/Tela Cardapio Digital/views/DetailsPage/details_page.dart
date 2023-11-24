import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/TelaCardapioDigital.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/DetailsPage/single_item_navBar.dart';

import '../../../../../models/DataBaseController/template/produtos_model.dart';

class ItemDetailsPage extends StatelessWidget {
  final ProdutoModel produto_selecionado;
  const ItemDetailsPage({super.key, required this.produto_selecionado});


  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: CupertinoColors.black.withBlue(6),
      body: SafeArea(child: Padding(padding: EdgeInsets.all(12),child: Column(

        children: [
          botoesSuperior(),

          Padding(padding: EdgeInsets.all(12),child: Image.asset('lib/repository/assets/card_produto.jpeg',height: _height/2, fit: BoxFit.cover,),),
          
          SizedBox(height: 10,),


          detalhesProdutos(),




        ],
      ),),),

      bottomNavigationBar: SingleItemNavBar(),

    );
  }


  Widget botoesSuperior(){
    return      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: ()=> Get.to(TelaCardapioDigital(id: '1234')),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),

        InkWell(
          onTap: ()=> Text('salvando..'),
          child: Icon(
            Icons.shopping_cart_rounded,
            color: Colors.white,
            size: 32,
          ),
        )
      ],
    );
  }


  Widget detalhesProdutos(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: produto_selecionado.nome, size: 28, color: Colors.white, weight: FontWeight.bold,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           InkWell(
             onTap: (){},
             child:  Container(
               alignment: Alignment.center,
               width: 30,
               height: 30,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: Icon(CupertinoIcons.minus_circle_fill),
             ),
           ),

            SizedBox(width: 15,),

            CustomText(text: '3', size: 28, color: Colors.white, weight: FontWeight.bold,),

            SizedBox(width: 15,),

            InkWell(
              onTap: (){},
              child:  Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(CupertinoIcons.plus_circle_fill),
              ),
            ),


            SizedBox(height: 15,),


          ],
        ),

        CustomText(text: 'DESCRIÇÃO: Lorem Ipsum Description\n${produto_selecionado.ingredientes}', size: 28, color: Colors.white, weight: FontWeight.bold,),
        //CustomText(text: 'Ingredientes: ${produto.ingredientes?.join(', ')}'),

      ],
    );
  }
}
