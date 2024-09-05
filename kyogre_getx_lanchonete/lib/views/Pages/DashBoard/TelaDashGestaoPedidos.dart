import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

import '../../../app/widgets/Design/new_kanban_coluna.dart';

class TelaGestaoDePedidosDashBoard extends StatelessWidget {
  final FilaDeliveryController filaDeliveryController =
      Get.put(FilaDeliveryController());
  final PedidoController pedidoController =
      Get.put(PedidoController(Get.find<FilaDeliveryController>()));

  TelaGestaoDePedidosDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GestaoPedidosController()); // Inicializa o controlador

    return Scaffold(
      appBar: const NightWolfAppBar(),
      body: Row(
        children: [
          //PesquisarDadosWidet(),
          Coluna(
            columnIndex: 1,
            color: Colors.red,
            titulo: "Pedidos sendo Preparados",
          ),
          Coluna(
              columnIndex: 2,
              color: Colors.orange,
              titulo: "Pedidos para Entrega"),
          Coluna(
              columnIndex: 3,
              color: Colors.green,
              titulo: "Pedidos Finalizados"),
        ],
      ),
    );
  }
}
