
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class CardPedido2 extends StatelessWidget {
  final Fila<Pedido> filaPedidos;

  CardPedido2({required this.filaPedidos});

  @override
  Widget build(BuildContext context) {
    final List<Pedido> pedidosList = [];

    // Iterate through the elements in the Fila and add them to the pedidosList
    No<Pedido>? current = filaPedidos.first;
    while (current != null) {
      pedidosList.add(current.data);
      current = current.next;
    }

    return Expanded(
      child: Container(
        color: Colors.red,
        child: ListView.builder(
          itemCount: pedidosList.length,
          itemBuilder: (context, index) {
            final pedido = pedidosList[index];
            // Now you can access the properties of 'pedido' and build your card
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.white,
              child: Column(
                children: [
                  Text('Pedido: ${pedido.id}'),
                  Text('Nome: ${pedido.nome}'),
                  // Other widgets displaying 'pedido' properties
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}




class ColunaPedidosParaAceitar extends StatefulWidget {
  const ColunaPedidosParaAceitar({
    Key? key,
    required this.pedidoController,
  }) : super(key: key);

  final PedidoController pedidoController;

  @override
  _ColunaPedidosParaAceitarState createState() =>
      _ColunaPedidosParaAceitarState();
}

class _ColunaPedidosParaAceitarState extends State<ColunaPedidosParaAceitar> {
  final FilaDeliveryController filaController =
  Get.put(FilaDeliveryController());

  @override
  void initState() {
    super.initState();
    widget.pedidoController.startFetchingPedidos();
  }

  @override
  Widget build(BuildContext context) {
    final filaPedidos = filaController.getFila();

    return Expanded(
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CustomText(
                  text: 'Pedidos Sendo Preparados na Cozinha',
                  weight: FontWeight.bold,
                  size: 20),
            ),
            const SizedBox(height: 10.0),


            // Cards Pedido Layout
            const CupertinoTheme(data: CupertinoThemeData(
              primaryColor: Colors.indigoAccent,
            ), child: Card(
              color: Colors.indigoAccent,
                shadowColor: Colors.yellow,
              child: CupertinoListTile(
                title: CustomText(text: 'nome'),
                trailing: Text('ID PEDIDO'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cliente: {pedido.nome}'),
                    Text('Endereço: {pedido.endereco}'),
                    Text('Itens do Pedido:'),
                      //Text('{item['quantidade']}x {item['nome']} - {item['preco']}'),
                    Text('Total a Pagar: {pedido.totalPagar}'),
                    Divider(), // Adicione uma linha divisória entre os dados do pedido e da fila

                  ],
                ),
              ),
            )),





            // Lista de Pedidos na Fila
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: filaPedidos.length + 1,
                  itemBuilder: (context, index) {
                    final pedido = filaPedidos[index];

                    return Column(
                      children: [
                        if (pedido != null)
                        CardPedido(pedido: pedido,
                        ),
                        const Divider(),
                        const SizedBox(height: 10.0), // Espaço entre os cards
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

