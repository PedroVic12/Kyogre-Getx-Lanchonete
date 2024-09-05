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
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ExpansionTile(
          initiallyExpanded:
              true, // Se quiser que inicialmente esteja expandido
          title: Text(
              'Cliente: ${task.pedido.nome_cliente} - ID: ${task.pedido.status}',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  await kanbanController.atualizarStatusPedido(
                      task.pedido.id, 'pull');
                  kanbanController.moveLeft(task);
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () async {
                  await kanbanController.atualizarStatusPedido(
                      task.pedido.id, 'push');
                  kanbanController.moveRight(task);
                },
              ),
            ],
          ),

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Status Cliente = ${task.pedido.id}"),
                const Divider(color: Colors.black, indent: 2.0),
                const CustomText(text: 'Itens do Pedido:'),
                const SizedBox(height: 8),
                for (var item in task.pedido.carrinho)
                  CustomText(
                      text: '${item.quantidade}x ${item.nome}',
                      color: CupertinoColors.systemRed,
                      weight: FontWeight.bold,
                      size: 15),
                const SizedBox(height: 8),
                CustomText(
                    text: 'Total a Pagar: R\$ ${task.pedido.totalPagar} Reais',
                    weight: FontWeight.bold),
                CustomText(
                    text: 'Forma de pagamento: ${task.pedido.formaPagamento}'),
                const SizedBox(height: 8),
                CustomText(
                    text: 'Endereço: ${task.pedido.endereco}',
                    weight: FontWeight.bold),
                CustomText(text: 'Complemento: ${task.pedido.complemento}'),
                const Divider(color: Colors.black, indent: 2.0),
                botaoDashBoard(task.pedido.status, kanbanController, task),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget botaoDashBoard(String statusPedido,
      GestaoPedidosController kanbanController, Task task) {
    String buttonText = getButtonText(task.pedido.status);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreenAccent,
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(
              text: buttonText, color: Colors.black, weight: FontWeight.bold),
          const Icon(Icons.arrow_circle_right, size: 32),
        ],
      ),
    );
  }

  String getButtonText(String status) {
    switch (status) {
      case 'Producao':
        return 'Avançar Pedido!';
      case 'Entrega':
        return 'Despachar Pedido';
      case 'Concluido':
        return 'Pedido Finalizado';
      default:
        return '';
    }
  }
}
