import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/Carrinho/CarrinhoController.dart';


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
