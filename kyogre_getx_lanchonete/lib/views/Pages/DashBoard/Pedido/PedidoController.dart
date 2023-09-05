// ignore_for_file: avoid_print

import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'dart:convert';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';

// TODO ALERTA NAO ESTA MOSTRANDO OS DADOS DA REQUISIÇÃO

// TODO ACEITAR PEDIDO E JOGAR NA FILA

// TODO CRIAR UM CARD PARA CADA PEDIDO NA FILA

class PedidoController extends GetxController {

  final Map<int, bool> pedidosAlertaMostrado = {};
  Timer? timer;
  bool showAlert = false; // Novo estado para controlar a exibição do alerta]




  @override
  void onInit() {
    startFetchingPedidos();

    super.onInit();
    update();
  }

  void startFetchingPedidos() {
    try {
      timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
        fetchPedidos();
      });
    } catch (e) {
      print(e);
    }
  }

  @override

  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future fetchPedidos() async {

    final filaDeliveryController = Get.find<FilaDeliveryController>();

    try {
      final response =
      await http.get(Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos'));

      print('\n\nResponse Status Code: ${response.statusCode}');

      // Reset the pedidosAlertaMostrado map
      pedidosAlertaMostrado.clear();


      if (response.statusCode == 200) {

        // Pegando o Json da requisição
        final jsonData = json.decode(response.body);
        print('\nResponse Body: ${jsonData}\n\n');



        if (jsonData is List<dynamic> && jsonData.isNotEmpty) {
          // Reset showAlert flag before processing new orders
          showAlert = false;

          for (final novoPedido in jsonData) {
            final pedidoId = novoPedido['id_pedido'];

            //! O alerta é chamado aqui pela Fila
            filaDeliveryController.carregarPedidos(jsonData);
            //showNovoPedidoAlertDialog(novoPedido);

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
    final filaDeliveryController = Get.find<FilaDeliveryController>();

    //filaDeliveryController.inserirPedido(pedidoJson as Pedido);

    final pedido = Pedido.fromJson(pedidoJson);
    filaDeliveryController.inserirPedido(pedido);
    print('\n\nPedido adicionado à fila de entrega!');
  }




  Future<void> showNovoPedidoAlertDialog(dynamic pedido) async {
    final filaDeliveryController = Get.find<FilaDeliveryController>();


    final pedidoId = pedido['id_pedido'];
    print(pedidoId);
    print('\n\nItens na fila: ${filaDeliveryController.FILA_PEDIDOS.tamanhoFila()}');

    if (pedidosAlertaMostrado.containsKey(pedidoId)) {
      return;
    }

    if (!pedidosAlertaMostrado.containsKey(pedidoId)) {

      print('\n\nPedido ${pedidoId} não está na fila, mostrando alerta...');

      final List<String> itensPedido = (pedido['pedido'] as List<dynamic>)
          .map((item) => item['nome'] as String)
          .toList();

      final currentRoute = Get.currentRoute;
      final isDashPage = currentRoute == '/dash';
      print(isDashPage);

      if (!showAlert && isDashPage) {
        showAlert = true;

        await Get.to(() => AlertaPedidoWidget(
          nomeCliente: pedido['nome'] ?? '',
          enderecoPedido: pedido['endereco'] ?? '',
          itensPedido: itensPedido,
          btnOkOnPress: () {
            print('\n\nPedido Aceito!');
            Get.back();
            Get.to(DashboardPage());

            aceitarPedido(pedido);

            showAlert = false;
            pedidosAlertaMostrado[pedidoId] = true;
          },
        ));
      }
    }
  }
}