import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/themes%20/cores.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';

import '../../../views/Pages/Carrinho/CarrinhoPage.dart';
import '../../../views/Pages/Carrinho/controller/backend_wpp.dart';
import '../../../views/Pages/Tela Cardapio Digital/controllers/cardapio_controller.dart';


class ModalInferior extends StatelessWidget {
   ModalInferior({super.key});
  final CarrinhoPedidoController carrinho = Get.put(CarrinhoPedidoController());
  final backEndWhatsapp Groundon = Get.put(backEndWhatsapp());

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration:  BoxDecoration(
            color: Colors.blueGrey.shade200,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(50)
            ),
            boxShadow:[
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 2
              )
            ]
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child:    Obx(
                  ()=> Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10,),
                          CustomText(text: 'Total: R\$ ${carrinho.totalPrice.toStringAsFixed(2)}', size: 20),
                          CustomText(text: 'Itens no carrinho ${carrinho.SACOLA.length}'),
                        ],
                      ),
                      BotaoNavegacao1(),
                    ],
                  ),
                )
              )
          ),
        )
    );
  }


   Widget BotaoNavegacao1() {
     final CarrinhoController carrinhoOld = Get.put(CarrinhoController());
     final CardapioController controller = Get.find<CardapioController>();

     return ElevatedButton(
         onPressed: () {
           Get.to(CarrinhoPage());
         },
         style: ElevatedButton.styleFrom(
           backgroundColor: CupertinoColors.activeBlue,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(30),
           ),
         ),
         child: Center(
           child: Row(
             children: [
               Icon(
                 Icons.shopify_rounded,
                 size: 20,
                 color: Colors.white,
               ),
               CustomText(
                 text: 'VER CARRINHO',
                 color: Colors.white,
                 size: 20,
               )
             ],
           ),
         ));
   }

}



class BarraInferiorPedido extends StatelessWidget {
  final CarrinhoPedidoController carrinho = Get.put(CarrinhoPedidoController());
  final backEndWhatsapp Groundon = Get.put(backEndWhatsapp());


  BarraInferiorPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration:  BoxDecoration(
            color: cor_7,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(50)
            ),
            boxShadow:[
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 2
              )
            ]
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Obx(
                      ()=> Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(text: 'Total: R\$ ${carrinho.totalPrice.toStringAsFixed(2)}', size: 20),
                        CustomText(text: 'Itens no carrinho ${carrinho.SACOLA.length}')
                      ],
                    ),
                  )
              ),

              BotaoWpp(context)

            ],
          ),
        )
    );
  }

  Widget BotaoWpp(context){
    return    Padding(padding: const EdgeInsets.all(8),child:
    SizedBox(
        height: 40,
        child: ElevatedButton(onPressed: () async {

          final result = await showCupertinoDialog(
              context: context,
              builder: createDialog
          );

          if (result == true) { // Se o resultado for true, o usuário clicou em "Sim".
            try {
              const String groundon_number1 = '5521983524026';
              final String messagemWhatsappPedido = Groundon.gerarResumoPedidoCardapio();
              print(messagemWhatsappPedido);
              Groundon.enviarPedidoWhatsapp(phone: groundon_number1, message: messagemWhatsappPedido);


            } catch (e) {
              print('Erro ao tentar abrir o WhatsApp: $e');
              Get.snackbar(
                  'Erro: ${e}',
                  'Não foi possível abrir o WhatsApp. Por favor, tente novamente.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white
              );
            }
          }
        }, style: ElevatedButton.styleFrom(
            backgroundColor: CupertinoColors.systemGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),
            child: const Text('Continuar o Pedido no Whatsapp', style: TextStyle(fontSize: 16),))

    )
    );
  }
}




Widget createDialog(BuildContext context) => CupertinoAlertDialog(
  title: const CustomText(text: 'Confirma os dados do Pedido?', weight: FontWeight.bold,),
  content: const CustomText(
    text: 'Deseja continuar e finalizar o pedido ir para o WhatsApp?',
  ),
  actions: [
    CupertinoDialogAction(
        child: const CustomText(text:'Sim', weight: FontWeight.bold,),
        onPressed: (){
          Get.back(result: true);
        }
    ),
    CupertinoDialogAction(
        child: const CustomText(text:'Não', weight: FontWeight.bold,),
        onPressed: (){
          Get.back(result: false);
        }
    )
  ],
);


