import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';

class FilaDeliveryController extends GetxController {
  final Rx<Fila> FILA_PEDIDOS = Fila().obs;
  final controller = Get.find<PedidoController>();

  final List<dynamic> pedidosParaAlertas = [];

  getFila() => FILA_PEDIDOS;
  getTodosPedidos() => FILA_PEDIDOS.value.todosPedidos();


  carregarPedidos(pedidosDoServidor) {

    print('Tamanho da Fila: ${FILA_PEDIDOS.value.tamanhoFila()}');

    pedidosDoServidor.forEach((pedidosList) {
      final pedido = Pedido.fromJson(pedidosList);
      print(pedido);
      if (!FILA_PEDIDOS.value.contemPedidoComId(pedido.id)) {
        pedidosParaAlertas.add(pedidosList);
      }
    });
    _mostrarAlertaSeNecessario();
  }

  // Metodos de Controle
  _mostrarAlertaSeNecessario() {
    if (!_todosPedidosEstaoNaFila(pedidosParaAlertas) && !controller.showAlert) {
      showNovoPedidoAlertDialog(pedidosParaAlertas.removeAt(0));
    }
  }


  bool _todosPedidosEstaoNaFila(List<dynamic> pedidosList) {
    for (var pedidoJson in pedidosList) {
      final pedido = Pedido.fromJson(pedidoJson);
      if (!FILA_PEDIDOS.value.contemPedidoComId(pedido.id)) {
        return false;
      }
    }
    return true;
  }

  // Metodos Crud
  void inserirPedido(Pedido pedido) {
    FILA_PEDIDOS.value.push(pedido);
    FILA_PEDIDOS.refresh();
    print("Pedido inserido. Tamanho da fila agora: ${FILA_PEDIDOS.value.tamanhoFila()}");
  }

  Pedido? removerPedido() {
    return FILA_PEDIDOS.value.pop();
  }

  // Alerta de Pedido
  Future<void> showNovoPedidoAlertDialog(dynamic pedido) async {
    final controller = Get.find<PedidoController>();
    final pedidoId = pedido['id_pedido'];

    if (controller.pedidosAlertaMostrado.containsKey(pedidoId)) {
      return;
    }

    if (!controller.pedidosAlertaMostrado.containsKey(pedidoId)) {
      final List<String> itensPedido = (pedido['pedido'] as List<dynamic>)
          .map((item) => item['nome'] as String)
          .toList();

      final currentRoute = Get.currentRoute;
      final isDashPage = currentRoute == '/dash';

      if (!controller.showAlert && isDashPage) {
        print('Pedido ${pedidoId} não esta na Fila, mostrando o alerta...');
        controller.showAlert = true;

        await Get.to(() => AlertaPedidoWidget(
          nomeCliente: pedido['nome'] ?? '',
          enderecoPedido: pedido['endereco'] ?? '',
          itensPedido: itensPedido,
          btnOkOnPress: () {


            // Adicionando na fila
            Pedido novoPedido = Pedido.fromJson(pedido);
            inserirPedido(novoPedido);
            print('\n\nPedido Aceito!');

            //Controle de Rotas
            Get.back();
            Get.to(DashboardPage());

            // Ajustando parametros do alerta
            controller.showAlert = false;
            controller.pedidosAlertaMostrado[pedidoId] = true;
            _mostrarAlertaSeNecessario();
          },
        ));
      }
    }
  }
}
