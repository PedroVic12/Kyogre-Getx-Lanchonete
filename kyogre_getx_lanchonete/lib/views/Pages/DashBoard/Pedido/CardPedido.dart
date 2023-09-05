
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';





//TODO CORREÇÃO COM CARACTERRES ESPECIAOS NO CARD

// ESTUDAR LAYOUTS FLUTTER COMO UM JEDI

class CardPedido extends StatelessWidget {
  final Pedido pedido;
  final PedidoController pedidoController = Get.find<PedidoController>();
  final filaController = Get.find<FilaDeliveryController>();


   CardPedido({required this.pedido});

  @override
  Widget build(BuildContext context) {
    final filaPedidos = filaController.FILA_PEDIDOS;


    return Dismissible(
      key: Key(pedido.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        // Aqui você pode executar a lógica para concluir o pedido
        final pedidoController = Get.find<PedidoController>();
        //pedidoController.concluirPedido(pedido);

        // Mostre um snackbar informando que o pedido foi concluído
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pedido ${pedido.id} concluído!'),
          ),
        );
      },
      child: CupertinoTheme(

        data: CupertinoThemeData(
          primaryColor: Colors.indigoAccent,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Text('Pedido: ${pedido.id}'),

              CupertinoListTile(
                title: Text('Pedido ${pedido.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cliente: ${pedido.nome}'),
                    Text('Endereço: ${pedido.endereco}'),
                    Text('Itens do Pedido:'),
                    for (var item in pedido.itensPedido)
                      Text('${item['quantidade']}x ${item['nome']} - ${item['preco']}'),
                    Text('Total a Pagar: ${pedido.totalPagar}'),
                    Divider(), // Adicione uma linha divisória entre os dados do pedido e da fila

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
