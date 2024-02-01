
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/Custom/CustomText.dart';
import '../../../../app/widgets/Design/new_kanban_coluna.dart';

class PedidoCardInfo extends StatelessWidget {
  final Task task;
  const PedidoCardInfo({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kanbanController = Get.find<GestaoPedidosController>();

    return Card(
      elevation: 20.0,
      //color: Colors.lightGreenAccent,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: CupertinoListTile(
            title: CustomText(text:'Cliente: ${task.pedido.nome_cliente}',weight: FontWeight.bold, size: 18,),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Status Cliente = ${task.pedido.status}"),
                Divider(color: Colors.black,indent: 2.0),
                CustomText(text:'Itens do Pedido:'),
                SizedBox(height: 8),
                for (var item in task.pedido.carrinho)
                  CustomText(text:'${item.quantidade}x ${item.nome}',color: CupertinoColors.systemRed,weight: FontWeight.bold,size: 15,),
                SizedBox(height: 8),

                CustomText(text:'Total a Pagar: R\$ ${task.pedido.totalPagar} Reais',weight: FontWeight.bold),
                CustomText(text: 'Forma de pagamento: ${task.pedido.formaPagamento}'),
                SizedBox(height: 8),
                CustomText(text:'Endereço: ${task.pedido.endereco}',weight: FontWeight.bold),
                CustomText(text: 'Complemento: ${task.pedido.complemento}'),
                Divider(color: Colors.black,indent: 2.0),


                botaoDashBoard(task.pedido.status)
              ],
            ),
            trailing: Wrap(
            spacing: 12,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => kanbanController.moveLeft(task),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => kanbanController.moveRight(task),
              ),
          ],
        ),)));

  }
  String getButtonText(String status) {
    switch (status) {
      case 'Producao': return 'Avançar Pedido!';
      case 'Entrega': return 'Despachar Pedido';
      case 'Concluido': return 'Pedido Finalizado';
      default: return '';
    }
  }

  Widget botaoDashBoard(String statusPedido){
    String buttonText = getButtonText(task.pedido.status);


    return ElevatedButton(
        onFocusChange: (value) {
          Colors.blue;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreenAccent,
        ),
        onPressed: () {
        },

        onLongPress: (){

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(text: buttonText, color: Colors.black, weight: FontWeight.bold),
            Icon(Icons.arrow_circle_right, size: 32),
          ],
        ),
    );
  }

}