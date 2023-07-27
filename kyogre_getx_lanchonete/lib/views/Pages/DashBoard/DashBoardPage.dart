import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunaInfoPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunaPedidosCozinha.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunasPedidoProcessados.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class DashboardPage extends StatelessWidget {
  final PedidoController pedidoController = Get.put(PedidoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NightWolfAppBar(),
      body: Row(
        children: [
          ColunaPedidosParaAceitar(pedidoController: pedidoController),
          ColunaPedidosProcessados(),
          ColunaInfoPedidos(pedidoController: pedidoController),
        ],
      ),
    );
  }
}





