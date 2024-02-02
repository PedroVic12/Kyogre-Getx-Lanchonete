import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';
import '../../../views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import '../../../views/Pages/DashBoard/Pedido/card_pedido_info.dart';
import 'package:http/http.dart' as http;


class Task {
  final Pedido pedido;
  int columnIndex;

  Task({required this.pedido, this.columnIndex = 1});
}


class GestaoPedidosController extends GetxController {
  var tasks = <Task>[].obs;
  final FilaDeliveryController filaDeliveryController = Get.find<FilaDeliveryController>();

  @override
  void onInit() {
    super.onInit();
    carregarPedidos();
  }

  void carregarPedidos() async {
    var todosPedidos = await filaDeliveryController.getTodosPedidos();
    for (var pedido in todosPedidos) {
      var columnIndex = getStatusIndex(pedido.status);
      tasks.add(Task(pedido: pedido, columnIndex: columnIndex));
    }
  }

  Future<void> atualizarStatusPedido(int pedidoId, String acao) async {
    final url = Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos/$pedidoId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': pedidoId, 'acao': acao}),
    );


    if (response.statusCode == 200) {
      Get.snackbar("Pedido atualizado com sucesso!", "",showProgressIndicator: true,duration: Duration(seconds: 1));
    } else {
      print('Falha ao atualizar o pedido: ${response.body}');
    }
  }


  void moveRight(Task task) {
    if (task.columnIndex < 3) {
      task.columnIndex++;
      task.pedido.status = getIndexStatus(task.columnIndex); // Atualiza o status
      tasks.refresh();
    }
    //atualizarStatusPedido(task.pedido.id, getIndexStatus(task.columnIndex));

  }

  void moveLeft(Task task) async {

    if (task.columnIndex > 1) {
      task.columnIndex--;
      task.pedido.status = getIndexStatus(task.columnIndex); // Atualiza o status
      tasks.refresh();
    }
  }

  int getStatusIndex(String status) {
    switch (status) {
      case 'Producao': return 1;
      case 'Entrega': return 2;
      case 'Concluido': return 3;
      default: return 1;
    }
  }

  String getIndexStatus(int index) {
    switch (index) {
      case 1: return 'Producao';
      case 2: return 'Entrega';
      case 3: return 'Concluido';
      default: return 'Producao';
    }
  }
}



class Coluna extends StatelessWidget {
  final int columnIndex;
  final Color color;
  final String titulo;

  Coluna({required this.columnIndex, required this.color, required this.titulo});

  @override
  Widget build(BuildContext context) {
    final kanbanController = Get.find<GestaoPedidosController>();

    return Expanded(
      child: Container(
        color: color,
        child: Obx(() {
          var columnTasks = kanbanController.tasks.where((t) => t.columnIndex == columnIndex).toList();

          return Column(children: [
            Text("$titulo - ($columnIndex)", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Divider(
              color: Colors.black,
            ),
            const SizedBox(height: 10.0),

           Expanded(child:  ListView.builder(
             itemCount: columnTasks.length,
             itemBuilder: (context, index) {
               return PedidoCardInfo(task: columnTasks[index]);
             },
           ))
          ],);
        }),
      ),
    );
  }
}

