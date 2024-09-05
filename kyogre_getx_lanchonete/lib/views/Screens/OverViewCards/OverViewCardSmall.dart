import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/InfoCards/InfoCardSmall.dart';

import '../../Pages/DashBoard/Pedido/CardPedido.dart';

class OverViewCardsSmallScreen extends StatelessWidget {
  const OverViewCardsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
              title: 'Em processo', value: '7', isActive: true, onTap: () {}),
          SizedBox(height: width / 64),
          const CardPedido(
            status_pedido: "Finalizado",
          ),
          InfoCardSmall(
              title: 'Pedidos Concluidos',
              value: '10',
              isActive: true,
              onTap: () {}),
          SizedBox(height: width / 64),
          InfoCardSmall(
              title: 'Esta sendo preparado',
              value: '10',
              isActive: true,
              onTap: () {}),
          SizedBox(height: width / 64),
          InfoCardSmall(
              title: 'Pedidos Cancelados ',
              value: '10',
              isActive: true,
              onTap: () {}),
          SizedBox(height: width / 64),
        ],
      ),
    );
  }
}
