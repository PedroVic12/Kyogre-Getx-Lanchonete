import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/themes%20/cores.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';


class BarraInferiorPedido extends StatelessWidget {
  final CarrinhoController controller = Get.put(CarrinhoController());

  BarraInferiorPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration:  BoxDecoration(
            color: cor_7,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
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
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [



              Obx(
                      ()=> Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total: ', style: TextStyle(
                            fontSize: 24,fontWeight: FontWeight.bold
                        )),
                        Text('R\$ ${controller.total}', style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold    )),

                      ],
                    ),
                  )
              ),

              //Botao
              Padding(padding: const EdgeInsets.all(8),child:
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
                        final String messagemWhatsappPedido = controller.gerarResumoPedidoCardapio();
                        print(messagemWhatsappPedido);
                        controller.enviarPedidoWhatsapp(phone: groundon_number1, message: messagemWhatsappPedido);


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
              )
            ],
          ),
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
          Get.back(result: true); // Retorna true quando o usuário clicar em "Sim".
        }
    ),
    CupertinoDialogAction(
        child: const CustomText(text:'Não', weight: FontWeight.bold,),
        onPressed: (){
          Get.back(result: false); // Retorna false quando o usuário clicar em "Não".
        }
    )
  ],
);
