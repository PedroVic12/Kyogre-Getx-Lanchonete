
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';
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
  final FilaDeliveryController filaDeliveryController = Get.find();
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
    final total_pedidos = filaDeliveryController.FILA_PEDIDOS.value.tamanhoFila();

    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CustomText(
                  text: 'Pedidos Sendo Preparados na Cozinha',
                  weight: FontWeight.bold,
                  size: 24),
            ),
            Divider(
              color: Colors.black,
            ),
            const SizedBox(height: 10.0),

            Center(
              child: CustomText(text:'Total de pedidos: ${total_pedidos}'),

            ),
            CardPedido(),


          ],
        ),
      ),
    );
  }
}

