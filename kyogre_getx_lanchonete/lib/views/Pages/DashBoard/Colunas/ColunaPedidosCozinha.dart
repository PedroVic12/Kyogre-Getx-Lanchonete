
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';


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
  FilaDeliveryController filaDeliveryController = FilaDeliveryController();
  final pedidoController = PedidoController();




  @override
  void initState() {
    super.initState();
    widget.pedidoController.startFetchingPedidos();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
    filaDeliveryController.getTodosPedidos();
  }


  @override
  Widget build(BuildContext context) {
    RxList<Pedido> filaPedidos = RxList<Pedido>();

    final pedidos = filaDeliveryController.getTodosPedidos();

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
                  size: 22),
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
            // Adicionando Obx para tornar esta parte reativa:
            Obx(() =>Expanded(child:  ListView(
              children: filaDeliveryController.FILA_PEDIDOS.value.todosPedidos().map((pedido) {
                return Card(
                  child: ListTile(
                    title: Text(pedido.nome),
                    subtitle: Text("Pedido ID: ${pedido.id}"),
                  ),
                );
              }).toList(),
            )))


          ],
        ),
      ),
    );
  }
}

