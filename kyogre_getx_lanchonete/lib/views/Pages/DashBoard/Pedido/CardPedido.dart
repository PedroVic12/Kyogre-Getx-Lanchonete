
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';





//TODO CORREÇÃO COM CARACTERRES ESPECIAOS NO CARD

// ESTUDAR LAYOUTS FLUTTER COMO UM JEDI
class CardPedido extends StatelessWidget {
  const CardPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilaDeliveryController filaDeliveryController = Get.find();

    return // Lista de Pedidos na Fila
      Obx(() {
        final todosPedidos = filaDeliveryController.getTodosPedidos();

        // Se a fila estiver vazia
        if (todosPedidos.isEmpty) {
          return Center(
            child: Text('A fila está vazia'),
          );
        }

        // Caso contrário, liste todos os pedidos
        return Expanded(
          child: ListView.builder(
            itemCount: todosPedidos.length,
            itemBuilder: (context, index) {
              final pedido = todosPedidos[index];
              return Card(
                elevation: 18.0,  // Adiciona sombra
                color: Colors.green,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),  // Espaçamento entre os cards
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),  // Arredonda os cantos do card
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CupertinoListTile(
                    title: CustomText(text:'Cliente: ${pedido.nome}',weight: FontWeight.bold, size: 18,),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text:'Itens do Pedido:'),
                        SizedBox(height: 8),
                        for (var item in pedido.itensPedido)
                          CustomText(text:'${item['quantidade']}x ${item['nome']} - ${item['preco']}',color: CupertinoColors.systemRed,weight: FontWeight.bold,size: 18,),
                        SizedBox(height: 8),

                        CustomText(text:'Total a Pagar: ${pedido.totalPagar}'),
                        CustomText(text: 'Forma de pagamento: ${pedido.formaPagamento}'),
                        CustomText(text:'Endereço: ${pedido.endereco}',weight: FontWeight.bold),
                        Divider(), // Adicione uma linha divisória entre os dados do pedido e da fila

                      ],
                    ),
                    trailing: CustomText(text: 'Pedido ID: ${pedido.id}'),


                  ),
                ),
              );
            },
          ),
        );
      });
  }
}
