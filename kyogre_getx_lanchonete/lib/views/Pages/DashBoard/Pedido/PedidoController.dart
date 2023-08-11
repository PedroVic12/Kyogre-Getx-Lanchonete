import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';

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
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      fetchPedidos();
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }


  Future<void> fetchPedidos() async {
    try {
      final response = await http
          .get(Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['results'] is List<dynamic>) {
          final int previousLength = pedidos.length;
          pedidos.assignAll(jsonData['results']);
          final int newLength = pedidos.length;

          if (newLength > previousLength) {
            final novoPedido = pedidos[newLength - 1];
            showNovoPedidoAlertDialog(novoPedido);
          }
        }
      } else {
        throw Exception('Failed to fetch pedidos');
      }
    } catch (e) {
      print('Erro ao fazer a solicitação GET: $e');
      //throw Exception('Failed to fetch pedidos');
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
      pedido: pedido,
      horaAceite: DateTime.now(),
    );
    pedidosAceitos.add(pedidoAceito);
    filaDeliveryController.inserirPedido(pedidoAceito);
    Get.back(); // Voltar para a página anterior
  }

  void showNovoPedidoAlertDialog(dynamic pedido) {
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
                    enderecoPedido: pedido['endereco_cliente'] ?? '',
                    itensPedido: pedido['itens_pedido'] != null
                        ? List<String>.from(pedido['itens_pedido'])
                        : [],
                    btnOkOnPress: () {
                      aceitarPedido(pedido);
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

class FilaDeliveryController extends GetxController {
  final _filaPedidos = <Pedido>[].obs;

  List<Pedido> get filaPedidos => _filaPedidos.toList();

  void inserirPedido(Pedido pedido) {
    _filaPedidos.add(pedido);
  }

  Pedido? removerPedido() {
    if (_filaPedidos.isNotEmpty) {
      final pedido = _filaPedidos[0];
      _filaPedidos.removeAt(0);
      return pedido;
    }
    return null;
  }

  bool buscarPedido(Pedido pedido) {
    return _filaPedidos.contains(pedido);
  }
}

class Pedido {
  dynamic pedido;
  DateTime horaAceite;

  Pedido({required this.pedido, required this.horaAceite});
}
