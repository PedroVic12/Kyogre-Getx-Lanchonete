import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/TelaCardapioDigital.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/DetailsPage/single_item_navBar.dart';

import '../../../../../models/DataBaseController/template/produtos_model.dart';
import '../../../Carrinho/controller/sacola_controller.dart';
import '../../controllers/cardapio_form_controller.dart';
import '../../widgets/RadioButton.dart';
import '../../widgets/carrousel_images_widget.dart';

class ItemDetailsPage extends StatelessWidget {
  final ProdutoModel produto_selecionado;
   ItemDetailsPage({super.key, required this.produto_selecionado});
  final CarrinhoPedidoController carrinho = Get.find<CarrinhoPedidoController>();
  final CardapioFormController form_controller = Get.put(CardapioFormController());


  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(child: Padding(padding: EdgeInsets.all(6),child: ListView(

        children: [
          botoesSuperior(produto_selecionado),

          //Padding(padding: EdgeInsets.all(12),child: Image.asset('lib/repository/assets/card_produto.jpeg',height: _height/2, fit: BoxFit.cover,),),
          //Padding(padding: EdgeInsets.all(12),child: Image.asset('${produto_selecionado.imagem}',height: _height/2, fit: BoxFit.cover,),),
          CarrouselImagensWidget(),

          SizedBox(height: 10,),


          detalhesProdutos(),


         Obx(() {
           return  RadioButtonGroup(
             niveis: form_controller.niveis,
             nivelSelecionado: form_controller.nivelSelecionado,
           );
         }),


          CaixaDeTexto(
            controller: form_controller.observacoesDique,
            labelText: "Observações",
            height: 30,
          ),
        ],
      ),),),

      bottomNavigationBar: SingleItemNavBar( produto: produto_selecionado,),

    );
  }


  Widget botoesSuperior(produto){
    return      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: ()=> Get.back(),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),

        InkWell(
          //onTap: ()=> carrinho.adicionarCarrinho(produto),
          onTap: ()=> Get.to(CarrinhoPage()),
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


    //final produto = carrinho.SACOLA.keys.toList()[index];
    //final quantidade = carrinho.SACOLA[produto] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
         //end crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(text: produto_selecionado.nome, size: 28, color: Colors.white, weight: FontWeight.bold,),
            SizedBox(width: 30,),

            InkWell(
             onTap: (){
               carrinho.removerProduto(produto_selecionado);
             },
             child:  Container(
               alignment: Alignment.center,
               width: 40,
               height: 40,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: Icon(CupertinoIcons.minus_circle_fill,size: 32),
             ),
           ),

            SizedBox(width: 12,),
            Obx(() {
              final quantidade = carrinho.SACOLA[produto_selecionado] ?? 0;
              return   CustomText(text:' $quantidade', size: 28, color: Colors.white, weight: FontWeight.bold,);
            }),
            SizedBox(width: 12,),

            InkWell(
              onTap: (){
                carrinho.adicionarCarrinho(produto_selecionado);
              },
              child:  Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(CupertinoIcons.plus_circle_fill,size: 32,),
              ),
            ),


            SizedBox(height: 15,),


          ],
        ),

        CustomText(
          text: '\nIngredientes: ${produto_selecionado.ingredientes?.map((ingrediente) {
            return '${ingrediente[0].toUpperCase()}${ingrediente.substring(1)}';
          }).join(', ') ?? 'N/A'}', // 'N/A' é o texto padrão se não houver ingredientes
          size: 28,
          color: Colors.white,
          weight: FontWeight.bold,
        )



      ],
    );
  }
}





