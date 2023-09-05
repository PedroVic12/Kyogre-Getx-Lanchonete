// ignore_for_file: avoid_print

import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
    print('\n\n\n=================================================\n\t\t\t\tAPP KYOGRE\n=================================================');

    final filaDeliveryController = Get.find<FilaDeliveryController>();

    try {
      final response =
      await http.get(Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos'));

      print('\nResponse Status Code: ${response.statusCode}');

      // Reset the pedidosAlertaMostrado map
      pedidosAlertaMostrado.clear();


      if (response.statusCode == 200) {

        // Pegando o Json da requisição
        final jsonData = json.decode(response.body);
        print('\nResponse Body: ${jsonData}\n\n');

        if (jsonData is List<dynamic> && jsonData.isNotEmpty) {
          // Reset showAlert flag before processing new orders
          showAlert = false;

          //! O alerta é chamado aqui pela Fila
          filaDeliveryController.carregarPedidos(jsonData);

          //Loop que pega todos no corpo da Req
          for (final novoPedido in jsonData) {
            final pedidoId = novoPedido['id_pedido'];
            //print('Pedidos dentro do Array ${pedidoId}');
          }


        } else {
          print('Não possui pedidos ainda hoje');
        }
      }
    } catch (e) {
      print('Erro ao fazer a solicitação GET: $e');
    }
  }



}