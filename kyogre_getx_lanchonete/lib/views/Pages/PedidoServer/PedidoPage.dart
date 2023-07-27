// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class PedidoPage extends StatelessWidget {
  final PedidoController pedido_controller = Get.find<PedidoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
      ),
      body: Obx(() {
        // Implemente aqui a exibição dos pedidos recebidos pelo chatbot
        return ListView.builder(
          itemCount: pedido_controller.pedidos.length,
          itemBuilder: (context, index) {
            // Implemente aqui a exibição de cada pedido na lista
            return ListTile(
              title: Text(pedido_controller.pedidos[index]),
              // ...
            );
          },
        );
      }),
    );
  }
}
