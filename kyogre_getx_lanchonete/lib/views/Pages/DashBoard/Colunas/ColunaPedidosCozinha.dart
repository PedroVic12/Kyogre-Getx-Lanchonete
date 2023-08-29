
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

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
  final FilaDeliveryController filaController = Get.put(FilaDeliveryController());

  @override
  void initState() {
    super.initState();
    widget.pedidoController.startFetchingPedidos();
  }

  @override
  Widget build(BuildContext context) {

    final pedidos = widget.pedidoController.PEDIDOS_ACEITOS_ARRAY;
    final filaPedidos = filaController.FILA_PEDIDOS;

    return Expanded(
      //flex: 1,
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: CustomText(text: 'Pedidos Sendo preparados Na Cozinha',weight: FontWeight.bold, size: 20),

            ),

            const SizedBox(height: 10.0),
            Expanded(
              child: Obx(

                    () =>  ListView.builder(
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];
                  print('Pedido $pedido.nome');


                  return Column(
                    children: [
                      CardPedido(
                          pedido: pedido
                      )
                    ],
                  );
                },
              )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

