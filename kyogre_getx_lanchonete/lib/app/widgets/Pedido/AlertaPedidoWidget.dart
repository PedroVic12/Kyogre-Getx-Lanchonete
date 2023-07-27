import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class AlertaPedidoChegando extends StatelessWidget {
  const AlertaPedidoChegando({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            AnimatedButton(
              text: 'Botao Animado',
              color: CupertinoColors.systemYellow,
              pressEvent: (){
                AwesomeDialog(
                    context: context,

                    // Design do Alerta
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    showCloseIcon: true,

                    // Informações do alerta
                    title: 'Pedido de {nome_cliente} chegando!',
                    desc: 'Endereço Pedido: {} copiar IFOOD',

                    // Açõs do Alerta
                    btnCancelOnPress: (){},
                    btnOkOnPress: (){}

                ).show();
              },

            )
          ],
        ),
      ),
    );
  }
}
