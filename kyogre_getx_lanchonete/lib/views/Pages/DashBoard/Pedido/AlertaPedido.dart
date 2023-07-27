import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PedidoAlertWidget extends StatelessWidget {
  final String nomeCliente;
  final String enderecoPedido;

  const PedidoAlertWidget({
    required this.nomeCliente,
    required this.enderecoPedido,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  showCloseIcon: true,
                  title: 'Pedido de $nomeCliente chegando!',
                  desc: 'Endereço Pedido: $enderecoPedido copiar IFOOD',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              },
              child: Text('Mostrar Alerta'),
            ),
          ],
        ),
      ),
    );
  }
}
