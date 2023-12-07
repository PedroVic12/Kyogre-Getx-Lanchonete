
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';


class CardPedido extends StatelessWidget {
  const CardPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilaDeliveryController filaDeliveryController = Get.find<FilaDeliveryController>();
    final pikachu = PikachuController();
    return Obx(() {
      final todosPedidos = filaDeliveryController.getTodosPedidos();



      if (todosPedidos.isEmpty) {
        return Center(
          child: Text('A fila está vazia'),
        );
      }

      return Expanded(
        child: ListView.builder(
          itemCount: todosPedidos.length,
          itemBuilder: (context, index) {
            final pedido = todosPedidos[index];

            pikachu.cout(pedido.carrinho);
            for (var object in pedido.carrinho){
              print('${object.quantidade} - ${object.nome}');
            }

            return Dismissible(
              key: Key(pedido.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
              onDismissed: (direction) {
                filaDeliveryController.removerPedido();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Pedido concluído!")),
                );
              },
              child: Card(
                elevation: 18.0,
                color: Colors.green,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CupertinoListTile(
                    title: CustomText(text:'Cliente: ${pedido.nome_cliente}',weight: FontWeight.bold, size: 18,),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text:'Itens do Pedido:'),
                        SizedBox(height: 8),
                        for (var item in pedido.carrinho)
                          CustomText(text:'${item.quantidade}x ${item.nome}',color: CupertinoColors.systemRed,weight: FontWeight.bold,size: 15,),
                        SizedBox(height: 8),
                        CustomText(text:'Total a Pagar: ${pedido.totalPagar}',weight: FontWeight.bold),
                        CustomText(text: 'Forma de pagamento: ${pedido.formaPagamento}'),
                        SizedBox(height: 8),
                        CustomText(text:'Endereço: ${pedido.endereco}',weight: FontWeight.bold),
                        CustomText(text: 'Complemento: ${pedido.complemento}'),
                        Divider(),

                      ],
                    ),
                    trailing: Column(children: [CustomText(text: 'ID: ${pedido.id}'), IconButton(onPressed: (){},
                        icon: Icon(Icons.arrow_circle_right,size: 32,))],),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}