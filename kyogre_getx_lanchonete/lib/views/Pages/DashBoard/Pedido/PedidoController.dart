import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'dart:convert';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';



class PedidoController extends GetxController {
  //final PEDIDOS_ACEITOS_ARRAY = <Pedido>[].obs;

  final Map<int, bool> pedidosAlertaMostrado = {};
  Timer? timer;
  bool showAlert = false; // Novo estado para controlar a exibição do alerta

  final filaDeliveryController = Get.put(FilaDeliveryController());


  @override
  void onInit() {
    startFetchingPedidos();
    super.onInit();
    update();
  }

  void startFetchingPedidos() {
    try {
      timer = Timer.periodic(Duration(seconds: 7), (Timer timer) {
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
    final filaDelivery = filaDeliveryController;
    try {
      final response =
      await http.get(Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos'));

      print('\n\nResponse Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('\nResponse Body: ${jsonData}\n\n');

        if (jsonData is List<dynamic> && jsonData.isNotEmpty) {
          for (final novoPedido in jsonData) {
            // Verifique se o pedido já foi processado
            final pedidoId = novoPedido['id_pedido'];
            if (pedidosAlertaMostrado.containsKey(pedidoId) && pedidosAlertaMostrado[pedidoId] == true) {
              continue; // O pedido já foi processado e o alerta já foi mostrado, vá para o próximo pedido
            }

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


  void aceitarPedido(Map<String, dynamic> pedidoJson) {
    final pedido = Pedido.fromJson(pedidoJson);
    filaDeliveryController.inserirPedido(pedido);
    print('\n\nPedido adicionado à fila de entrega!');
  }




  Future<void> showNovoPedidoAlertDialog(dynamic pedido) async {

    print('\n\nPedidos na Fila: ${filaDeliveryController.FILA_PEDIDOS.size}');

    // Pegando os dados em tempo real
    final pedidoId = pedido['id_pedido'];
    print('\n\nPedido de ID: $pedidoId');


    // fazendo um map
    final List<String> itensPedido = (pedido['pedido'] as List<dynamic>)
        .map((item) => item['nome'] as String)
        .toList();
    print(filaDeliveryController.todosPedidosNaFila(itensPedido));


    // Verifique se a página atual é a página do cardápio digital
    final currentRoute = Get.currentRoute; // Obtenha a rota atual
    final isDashPage = currentRoute == '/dash'; // Substitua com a rota da página do cardápio
    print(isDashPage);


    if (!showAlert && isDashPage) {
      showAlert = true; // Defina o estado para exibir o alerta

      await Get.to(() => AlertaPedidoWidget(
        nomeCliente: pedido['nome'] ?? '',
        enderecoPedido: pedido['endereco'] ?? '',
        itensPedido: itensPedido,
        btnOkOnPress: () {
          print('\n\nPedido Aceito!');
          Get.back();
          Get.to(DashboardPage());

          aceitarPedido(pedido);

          // Defina o estado para não exibir mais o alerta
          showAlert = false;
        },
      ));
    }
  }
}