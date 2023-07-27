import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertaPedidoWidget extends StatelessWidget {
  final String nomeCliente;
  final String enderecoPedido;
  final List<String> itensPedido;
  final VoidCallback? btnCancelOnPress;
  final VoidCallback? btnOkOnPress;

  const AlertaPedidoWidget({
    required this.nomeCliente,
    required this.enderecoPedido,
    required this.itensPedido,
    this.btnCancelOnPress,
    this.btnOkOnPress,
  });

  @override
  Widget build(BuildContext context) {
    final pedidoInfo = StringBuffer();
    pedidoInfo.writeln('Endereço do Pedido: $enderecoPedido');
    pedidoInfo.writeln('Itens do Pedido:');
    pedidoInfo.writeAll(itensPedido, '\n');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        showCloseIcon: true,
        title: 'Pedido de $nomeCliente chegando!',
        desc: pedidoInfo.toString(),
        btnOkText: 'Aceitar Pedido',
        btnCancelOnPress: (){
          Get.back();
        },
        btnOkOnPress: btnOkOnPress,
      ).show();
    });

    return SizedBox(); // Retorna um widget vazio para não renderizar nada
  }
}
