import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';

import '../../../app/widgets/Design/new_kanban_coluna.dart';

class TelaGestaoDePedidosDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(GestaoPedidosController()); // Inicializa o controlador

    return Scaffold(
      appBar: NightWolfAppBar(),
      body: Row(
        children: [
          Coluna(columnIndex: 1, color: Colors.red,titulo: "Pedidos sendo Preparados",),
          Coluna(columnIndex: 2, color: Colors.orange,titulo: "Pedidos para Entrega"),
          Coluna(columnIndex: 3, color: Colors.green,titulo: "Pedidos Finalizados"),
        ],
      ),
    );
  }
}
