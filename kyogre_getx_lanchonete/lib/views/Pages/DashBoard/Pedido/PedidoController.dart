// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';

class PedidoController extends GetxController {
  final pedidos = <dynamic>[].obs;
  final pedidosAceitos = <Pedido>[].obs;
  Timer? timer;

  final filaDeliveryController = Get.put(FilaDeliveryController());

  @override
  void onInit() {
    startFetchingPedidos();
    super.onInit();
  }

  void startFetchingPedidos() {
    // Requisição GET a cada 5 segundos (loop)
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
      await http.get(
          Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos'));

      print('\n\nResponse Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('\nResponse Body: ${jsonData}\n\n');

        if (jsonData is List<dynamic> && jsonData.isNotEmpty) {
          for (final novoPedido in jsonData) {
            showNovoPedidoAlertDialog(novoPedido);
          }
        } else {
          print('Não possui pedidos ainda hoje');
        }
      }
    } catch (e) {
      print('Erro ao fazer a solicitação GET: $e');
    }
  }

  void removePedido(dynamic pedido) async {
    final pedidoId = pedido['id'];

    // Faça a solicitação DELETE para excluir o pedido do servidor
    final response = await http.delete(Uri.parse(
        'https://rayquaza-citta-server.onrender.com/deletarPedido/$pedidoId'));

    if (response.statusCode == 200) {
      // Agora você pode remover o pedido localmente
      pedidos.remove(pedido);

      // Exiba uma Snackbar informando que o pedido foi removido com sucesso
      Get.snackbar(
        'Sucesso',
        'Pedido removido com sucesso.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    } else {
      // Exiba uma Snackbar informando o erro
      Get.snackbar(
        'Erro',
        'Falha ao remover o pedido.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void aceitarPedido(dynamic pedido) {
    final pedidoAceito = Pedido(
      pedido: pedido
    );
    pedidosAceitos.add(pedidoAceito);
    filaDeliveryController.inserirPedido(pedidoAceito);

    // Remover o pedido da lista de pedidos pendentes
    pedidos.remove(pedido);
  }

  void showNovoPedidoAlertDialog(dynamic pedido) {

    final List<String> itensPedido = (pedido['pedido'] as List<dynamic>)
        .map((item) => item['nome'] as String)
        .toList();


    Future.delayed(Duration.zero, () {
      final context = Get.context;
      if (context != null) {
        showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AlertaPedidoWidget(
                    nomeCliente: pedido['nome'] ?? '',
                    enderecoPedido: pedido['endereco'] ?? '',
                    itensPedido: itensPedido,
                    btnOkOnPress: () {
                      print('\nPedido Aceito!');
                      aceitarPedido(pedido);
                      Get.back();
                    },
                  ),

                ),
              ),
            );
          },
        );
      }
    });
  }
}
