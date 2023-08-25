import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';

class PedidoController extends GetxController {
  final pedidosAceitos = <Pedido>[].obs;
  Timer? timer;
  final Map<int, bool> pedidosAlertaMostrado = {};

  final filaDeliveryController = Get.put(FilaDeliveryController());

  @override
  void onInit() {
    startFetchingPedidos();
    super.onInit();
  }

  void startFetchingPedidos() {
    try {
      timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
        fetchPedidos();
      });
    } catch (e) {
      print('Nao possui pedidos ainda');
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> fetchPedidos() async {
    try {
      final response =
      await http.get(Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos'));

      print('\n\nResponse Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('\nResponse Body: ${jsonData}\n\n');

        if (jsonData is List<dynamic> && jsonData.isNotEmpty) {
          final novoPedido = jsonData.first;
          showNovoPedidoAlertDialog(novoPedido);
        } else {
          print('Não possui pedidos ainda hoje');
        }
      }
    } catch (e) {
      print('Erro ao fazer a solicitação GET: $e');
    }
  }

  void aceitarPedido(Map<String, dynamic> pedidoJson) {
    final pedido = Pedido.fromJson(pedidoJson);
    pedidosAceitos.add(pedido);
    print(pedidosAceitos[0].itensPedido);
    print('\n\nPedidos: ${pedidosAceitos[0].nome} | ${pedido.itensPedido}');
  }

  Future<void> showNovoPedidoAlertDialog(dynamic pedido) async {
    final pedidoId = pedido['id_pedido'];

    if (pedidosAlertaMostrado.containsKey(pedidoId)) {
      // Já mostrou o alerta para este pedido, então não mostrar novamente
      return;
    }

    final List<String> itensPedido = (pedido['pedido'] as List<dynamic>)
        .map((item) => item['nome'] as String)
        .toList();

    print(pedidoId);

    await Get.to(() => AlertaPedidoWidget(
      nomeCliente: pedido['nome'] ?? '',
      enderecoPedido: pedido['endereco'] ?? '',
      itensPedido: itensPedido,
      btnOkOnPress: () {
        print('\n\nPedido Aceito!');
        Get.back();
        aceitarPedido(pedido);

        // Marcar o alerta como mostrado para este pedido
        pedidosAlertaMostrado[pedidoId] = true;
      },
    ));
  }
}
