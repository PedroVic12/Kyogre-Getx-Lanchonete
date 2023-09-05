import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';


class FilaDeliveryController extends GetxController {
  // Instanciando o Objeto que recebe o padrao do pedido
  //final Fila FILA_PEDIDOS = Fila();
  final Rx<Fila> FILA_PEDIDOS = Fila().obs;

  final controller = Get.find<PedidoController>();



  // Getters
  getFila() => FILA_PEDIDOS;
  getTodosPedidos()=> FILA_PEDIDOS.value.todosPedidos();

  List array = [];
  bool buscarPedidoNaFila(int pedidoId) {
    for (final pedido in array) {
      if (pedido.id == pedidoId) {
        return true;
      }
    }
    return false;
  }


  carregarPedidos(pedidosDoServidor) {

    print('Tamannho Fila Delivery: ${FILA_PEDIDOS.value.tamanhoFila()}');
    print('Pegando os produtos: ${getTodosPedidos()}');

    pedidosDoServidor.forEach((pedidosList) {
      final pedido = Pedido.fromJson(pedidosList);

      print("\nCarregando pedido dentro da Requisição: ${pedido.id}");



      if (!FILA_PEDIDOS.value.contemPedidoComId(pedido.id)) {
        print('Mostrando o alerta...');
        showNovoPedidoAlertDialog(pedidosList);
      }
    });
  }


  void inserirPedido(Pedido pedido) {
    FILA_PEDIDOS.value.push(pedido);
    print("Pedido inserido. Tamanho da fila agora: ${FILA_PEDIDOS.value.tamanhoFila()}");

  }

  Pedido? removerPedido() {
    return FILA_PEDIDOS.value.pop();
  }



  Future<void> showNovoPedidoAlertDialog(dynamic pedido) async {
    final controller = Get.find<PedidoController>();


    final pedidoId = pedido['id_pedido'];
    print(pedidoId);
    print('\n\nItens na fila: ${FILA_PEDIDOS.value.tamanhoFila()}');

    if (controller.pedidosAlertaMostrado.containsKey(pedidoId)) {
      return;
    }

    if (!controller.pedidosAlertaMostrado.containsKey(pedidoId)) {

      print('\n\nPedido ${pedidoId} não está na fila, mostrando alerta...');

      final List<String> itensPedido = (pedido['pedido'] as List<dynamic>)
          .map((item) => item['nome'] as String)
          .toList();

      final currentRoute = Get.currentRoute;
      final isDashPage = currentRoute == '/dash';
      print(isDashPage);

      if (!controller.showAlert && isDashPage) {
        controller.showAlert = true;

        await Get.to(() => AlertaPedidoWidget(
          nomeCliente: pedido['nome'] ?? '',
          enderecoPedido: pedido['endereco'] ?? '',
          itensPedido: itensPedido,
          btnOkOnPress: () {
            print('\n\nPedido Aceito!');
            Get.back();
            Get.to(DashboardPage());

            Pedido novoPedido = Pedido.fromJson(pedido);
            inserirPedido(novoPedido);

            controller.showAlert = false;
            controller.pedidosAlertaMostrado[pedidoId] = true;
          },
        ));
      }
    }
  }



}

