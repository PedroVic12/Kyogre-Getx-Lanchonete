
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';



class SimpleFilaPage extends StatelessWidget {
  final FilaDeliveryController filaDeliveryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                color: Colors.black12,
                child: ListTile(
                  title: Text(pedido.nome),
                  subtitle: Text('Pedido ID: ${pedido.id}'),
                ),
              );
            },
          ),
        );
      });
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
  FilaDeliveryController filaDeliveryController = FilaDeliveryController();
  final pedidoController = PedidoController();


  @override
  void initState() {
    super.initState();
    widget.pedidoController.startFetchingPedidos();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });

  }


  @override
  Widget build(BuildContext context) {
    final TodosPedidos = filaDeliveryController.FILA_PEDIDOS.value.todosPedidos();
    print('Todos Pedidos: ${TodosPedidos}');


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






            // Lista de Pedidos na Fila
            SimpleFilaPage()

          ],
        ),
      ),
    );
  }
}

