import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';

class CardPedido extends StatelessWidget {
  final String status_pedido;
  const CardPedido({Key? key, required this.status_pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilaDeliveryController filaDeliveryController =
        Get.find<FilaDeliveryController>();
    final pikachu = PikachuController();
    final PedidoController controller = Get.find<PedidoController>();

    return Obx(() {
      final todosPedidos = filaDeliveryController.getTodosPedidos();

      if (todosPedidos.isEmpty) {
        return const Center(
          child: Text('A fila está vazia'),
        );
      }

      return Expanded(
        child: ListView.builder(
          itemCount: todosPedidos.length,
          itemBuilder: (context, index) {
            final pedido = todosPedidos[index];
            pikachu.cout(pedido.carrinho);

            var currentIndex = controller.getStatusIndex(pedido.status);

            for (var object in pedido.carrinho) {
              print('${object.quantidade} - ${object.nome}');
            }

            return Dismissible(
              key: Key(pedido.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
              onDismissed: (direction) {
                filaDeliveryController.removerPedido();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pedido concluído!")),
                );
              },
              child: Card(
                elevation: 20.0,
                //color: Colors.lightGreenAccent,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: CupertinoListTile(
                      title: CustomText(
                        text: 'Cliente: ${pedido.nome_cliente}',
                        weight: FontWeight.bold,
                        size: 18,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text:
                                  "Status Cliente = ${pedido.status} - Index $currentIndex"),
                          const Divider(color: Colors.black, indent: 2.0),
                          const CustomText(text: 'Itens do Pedido:'),
                          const SizedBox(height: 8),
                          for (var item in pedido.carrinho)
                            CustomText(
                              text: '${item.quantidade}x ${item.nome}',
                              color: CupertinoColors.systemRed,
                              weight: FontWeight.bold,
                              size: 15,
                            ),
                          const SizedBox(height: 8),
                          CustomText(
                              text:
                                  'Total a Pagar: R\$ ${pedido.totalPagar} Reais',
                              weight: FontWeight.bold),
                          CustomText(
                              text:
                                  'Forma de pagamento: ${pedido.formaPagamento}'),
                          const SizedBox(height: 8),
                          CustomText(
                              text: 'Endereço: ${pedido.endereco}',
                              weight: FontWeight.bold),
                          CustomText(
                              text: 'Complemento: ${pedido.complemento}'),
                          const Divider(color: Colors.black, indent: 2.0),
                          botaoDashBoard(pedido.status)
                        ],
                      ),
                      trailing: popUpConfig(pedido, context)),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget popUpConfig(pedido, context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  actions: [
                    CupertinoDialogAction(
                        child: const CustomText(
                          text: 'Fechar',
                          weight: FontWeight.bold,
                        ),
                        onPressed: () => Get.back()),
                  ],
                  title: const CustomText(text: 'Configurações'),
                  content: SizedBox(
                    height: 100, // Defina uma altura fixa para o ListView
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          color: Colors.grey.shade300,
                          child: ListTile(
                            focusColor: Colors.green,
                            leading: const Icon(Icons.add),
                            title: Column(
                              children: [
                                const Divider(),
                                Text(
                                    index == 0 ? 'Cancelar Pedido' : 'Resetar'),
                              ],
                            ),
                            onTap: () {
                              if (index == 0) {
                                //cancelarPedido();
                              } else if (index == 1) {
                                //avancarPedido();

                                //k_controller.avancarStatus(card);
                              }
                              Get.back();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.settings)),
        CustomText(
          text: "ID Pedido:\n${pedido.id}",
        )
      ],
    );
  }

  Widget botaoDashBoard(String statusPedido) {
    String txtBtn = "";
    if (statusPedido == "Producao") {
      txtBtn = "Avançar Pedido!";
    } else if (statusPedido == "Entrega") {
      txtBtn = "Despachar Pedido";
    }

    return ElevatedButton(
        onFocusChange: (value) {
          Colors.blue;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreenAccent,
        ),
        onPressed: () {},
        onLongPress: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(
              text: txtBtn,
              color: Colors.black,
              weight: FontWeight.bold,
            ),
            const Icon(
              Icons.arrow_circle_right,
              size: 32,
            ),
          ],
        ));
  }
}
