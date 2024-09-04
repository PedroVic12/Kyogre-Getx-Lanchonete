import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/kanban_column.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/TelaDashGestaoPedidos.dart';

import '../../../../app/widgets/Design/new_kanban_coluna.dart';
import 'ColunaPedidosCozinha.dart';

class ColunaPedidosProcessados extends StatelessWidget {
  late final PedidoController pedidoController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.orange,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: CustomText(
                  text: 'Pedidos em Produção',
                  weight: FontWeight.bold,
                  size: 24),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 10.0),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Get.to(TelaGestaoDePedidosDashBoard());
              },
              child: Text('Gestao de Pedidos'),
            ),

            // Implemente a lista de pedidos em processamento aqui
          ],
        ),
      ),
    );
  }
}
