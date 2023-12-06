

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';

import '../../../themes /cores.dart';
import '../../../views/Pages/Carrinho/controller/backend_wpp.dart';
import '../../../views/Pages/Carrinho/controller/sacola_controller.dart';
import '../../../views/Pages/Tela Cardapio Digital/controllers/pikachu_controller.dart';
import '../Custom/CustomText.dart';

class BarraInferiorPedido extends StatelessWidget {
  final CarrinhoPedidoController carrinho = Get.put(CarrinhoPedidoController());
  final GroundonBackEndController Groundon = Get.put(GroundonBackEndController());
  final CardapioController controller = Get.find<CardapioController>();
  final pikachu = PikachuController();


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
                        CustomText(text: 'Total: R\$ ${carrinho.totalPrice.toStringAsFixed(2)}', size: 20,color: Colors.white,),
                        CustomText(text: 'Itens no carrinho ${carrinho.SACOLA.length}',size: 20,color: Colors.white)
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
    return    Padding(padding: const EdgeInsets.all(12),child:
    Container(
        height: 40,
        child: ElevatedButton(onPressed: () async {

          await Groundon.enviarDadosPedidoGroundon(controller.idPedido);
          sendDadosServer(context);

        }, style: ElevatedButton.styleFrom(
            backgroundColor: CupertinoColors.systemGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)
            )
        ),
            child: const Text('Continuar o Pedido no Whatsapp', style: TextStyle(fontSize: 20,),))

    )
    );
  }

  void sendDadosServer(context) async {
    final result = await showCupertinoDialog(
        context: context,
        builder: createDialog
    );
    if (result == true) { // Se o resultado for true, o usuário clicou em "Sim".
      try {
        const String groundon_number1 = '5521983524026';
        const String messagemWhatsappPedido = 'Ola mundo';
        
       await Groundon.enviarPedidoWhatsapp(phone: groundon_number1, message: messagemWhatsappPedido);


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

}





