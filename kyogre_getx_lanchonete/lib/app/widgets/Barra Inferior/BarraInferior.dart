import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';


class BarraInferiorPedido extends StatelessWidget {
  final CarrinhoController controller = Get.find();

  BarraInferiorPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            color: CupertinoColors.white,
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
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [



              Obx(
                      ()=> Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total: ', style: TextStyle(
                            fontSize: 24,fontWeight: FontWeight.bold
                        )),
                        Text(' R\$ ${controller.total}', style: TextStyle(
                            fontSize: 24,fontWeight: FontWeight.bold
                        )),

                      ],
                    ),
                  )
              ),

              //Botao
              Padding(padding: EdgeInsets.all(8),child:
              SizedBox(
                  height: 40,
                  child: ElevatedButton(onPressed: (){

                    final String groundon_number1 = '5521983524026';
                    final String message = controller.gerarResumoPedidoCardapio();
                    controller.enviarPedidoWhatsapp(phone: groundon_number1, message: message);


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



class BarraInferiorWidget extends StatelessWidget {
  final double totalCarrinho;
  final CarrinhoController controller = Get.find();

  BarraInferiorWidget({Key? key, required this.totalCarrinho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
                    ()=> Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: ', style: TextStyle(
                          fontSize: 24,fontWeight: FontWeight.bold
                      )),
                      Text(' R\$ ${controller.total}', style: TextStyle(
                          fontSize: 24,fontWeight: FontWeight.bold
                      )),

                    ],
                  ),
                )
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(children: [
                  Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Continuar o Pedido no Whatsapp')
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
