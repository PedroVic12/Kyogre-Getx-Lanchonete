import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';

import '../../../views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import '../../../views/Pages/DashBoard/Pedido/PedidoController.dart';
import '../Custom/CustomText.dart';

class Task {
  String title;
  int columnIndex;

  Task({required this.title, this.columnIndex = 1});
}


class KanbanController extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Adicione alguns cards iniciais
    tasks.add(Task(title: 'Task 1'));
    tasks.add(Task(title: 'Task 2'));
    tasks.add(Task(title: 'Task 3'));
  }

  void moveRight(Task task) {
    if (task.columnIndex < 3) {
      task.columnIndex++;
      tasks.refresh();
    }
  }

  void moveLeft(Task task) {
    if (task.columnIndex > 1) {
      task.columnIndex--;
      tasks.refresh();
    }
  }
}





class ColunaKanban extends StatelessWidget {
  final int columnIndex;
  final Color color;

  ColunaKanban({required this.columnIndex, required this.color});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KanbanController>();

    return Expanded(
      child: Container(
        color: color,
        child: Obx(() {
          var columnTasks = controller.tasks.where((t) => t.columnIndex == columnIndex).toList();

          return ListView(
            children: columnTasks.map((task) => Card(
              child: ListTile(
                title: Text(task.title),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: columnIndex > 1 ? () => controller.moveLeft(task) : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: columnIndex < 3 ? () => controller.moveRight(task) : null,
                    ),
                  ],
                ),
              ),
            )).toList(),
          );
        }),
      ),
    );
  }
}
class KanbanBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(KanbanController()); // Inicializa o controlador

    return Scaffold(
      appBar: AppBar(title: Text('Kanban Board')),
      body: Row(
        children: [
          ColunaKanban(columnIndex: 1, color: Colors.red),
          ColunaKanban(columnIndex: 2, color: Colors.orange),
          ColunaKanban(columnIndex: 3, color: Colors.green),
        ],
      ),
    );
  }
}
