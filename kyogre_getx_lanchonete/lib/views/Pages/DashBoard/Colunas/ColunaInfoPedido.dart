import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/InfoCards/InfoCard.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class ColunaInfoPedidos extends StatelessWidget {
  const ColunaInfoPedidos({
    Key? key,
    required this.pedidoController,
  }) : super(key: key);

  final PedidoController pedidoController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,

      child: Container(
        width: 200.0,
        padding: EdgeInsets.all(8.0),
        child: Obx(
              () => InfoCard(
            title: "Pedidos Recebidos",
            value: pedidoController.pedidos.length.toString(),
            onTap: () {
              pedidoController.fetchPedidos();
            },
            isActive: true,
          ),
        ),
      ),
    );
  }
}
