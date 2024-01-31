import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardItem {
  String title;
  int status; // 1: Producao, 2: Entrega, 3: Concluido

  CardItem({required this.title, required this.status});
}
class KanbanController extends GetxController {
  var cards = <CardItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Exemplo de adição de cards
    cards.addAll([
      CardItem(title: 'Pedido 1', status: 1),
      CardItem(title: 'Pedido 2', status: 2),
      // Adicione mais cards conforme necessário
    ]);
  }

  void avancarStatus(CardItem card) {
    if (card.status < 3) {
      card.status++;
      cards.refresh();
    }
  }

  void retrocederStatus(CardItem card) {
    if (card.status > 1) {
      card.status--;
      cards.refresh();
    }
  }
}


class CardWidget extends StatelessWidget {
  final CardItem card;

  CardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    final KanbanController controller = Get.find<KanbanController>();

    return Card(
      child: ListTile(
        title: Text(card.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => controller.retrocederStatus(card),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => controller.avancarStatus(card),
            ),
          ],
        ),
      ),
    );
  }
}


class KanbanColumn extends StatelessWidget {
  final String title;
  final int columnIndex;
  final Color color;

  KanbanColumn({required this.title, required this.columnIndex, required this.color});

  @override
  Widget build(BuildContext context) {
    final KanbanController controller = Get.find<KanbanController>();

    return Expanded(
      child: Container(
        color: color,
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Obx(() => Column(
              children: controller.cards.where((card) => card.status == columnIndex).map((card) => CardWidget(card: card)).toList(),
            )),
          ],
        ),
      ),
    );
  }
}

class KanbanBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KanbanController controller = Get.put(KanbanController());

    return Scaffold(
      appBar: AppBar(title: Text('Kanban Board')),
      body: Row(
        children: [
          KanbanColumn(title: 'Pedidos em Produção', columnIndex: 1, color: Colors.red),
          KanbanColumn(title: 'Pedidos para Entrega', columnIndex: 2, color: Colors.orange),
          KanbanColumn(title: 'Pedidos Finalizados', columnIndex: 3, color: Colors.green),
        ],
      ),
    );
  }
}
