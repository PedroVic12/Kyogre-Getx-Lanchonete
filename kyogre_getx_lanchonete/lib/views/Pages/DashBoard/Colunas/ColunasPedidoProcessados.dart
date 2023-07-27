import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class ColunaPedidosProcessados extends StatelessWidget {
  late final PedidoController pedidoController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomText(text: 'Pedidos sendo processados'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                pedidoController.fetchPedidos();
              },
              child: Text('Atualizar Pedidos'),
            ),
            SizedBox(height: 10.0),
            // Implemente a lista de pedidos em processamento aqui
          ],
        ),
      ),
    );
  }
}