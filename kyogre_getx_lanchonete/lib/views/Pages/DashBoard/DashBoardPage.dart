import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunaInfoPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunaPedidosCozinha.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunasPedidoProcessados.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidosPage.dart';


class DashboardPage extends StatelessWidget {
  final PedidoController pedidoController = Get.find();
  final FilaDeliveryController filaDeliveryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NightWolfAppBar(),
      body: Column(
        children: [

          PesquisarDadosWidet(),
          Expanded(child: Row(
            children: [
              //PedidosServer(),
              ColunaPedidosParaAceitar(pedidoController: pedidoController),
              ColunaPedidosProcessados(),
              ColunaInfoPedidos(),
            ],
          ),)
        ],
      )
    );
  }
}


class PesquisarDadosWidet extends StatelessWidget {
  const PesquisarDadosWidet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Center(child: Text('Unidade: {Botafogo}'), ),
          SizedBox(width: 8),
          Text('Numero do Pedido'),

          SizedBox(width: 8),
          Text('Buscar pelo Cliente'),
          SizedBox(width: 8),

        ],
      ),
    );

  }
}



