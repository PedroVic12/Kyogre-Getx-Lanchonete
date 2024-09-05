import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/InfoCards/InfoCard.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class ColunaInfoPedidos extends StatelessWidget {
  const ColunaInfoPedidos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.green,
      //width: 200.0,
      padding: const EdgeInsets.all(8.0),
      child: const Column(
        // Use Column as the parent widget
        children: [
          Center(
            child: CustomText(
                text: 'Pedidos para Entrega',
                weight: FontWeight.bold,
                size: 24),
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: 10.0),
        ],
      ),
    ));
  }
}
