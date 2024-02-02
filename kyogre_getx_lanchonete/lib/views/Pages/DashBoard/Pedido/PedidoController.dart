// ignore_for_file: avoid_print

import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import '../../Tela Cardapio Digital/controllers/pikachu_controller.dart';
import 'modelsPedido.dart';


class PedidoController extends GetxController {
  late final allPedidosArray;
  final pikachu = PikachuController();

  final Map<int, bool> pedidosAlertaMostrado = {};
  Timer? timer;
  bool showAlert = false; // Novo estado para controlar a exibição do alerta]
  final FilaDeliveryController filaDeliveryController;
  PedidoController(this.filaDeliveryController);




  @override
  void onInit() {

    startFetchingPedidos();
    allPedidosArray =  filaDeliveryController.getTodosPedidos();
    super.onInit();
    update();
  }

  void startFetchingPedidos() {
    try {
      timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        fetchPedidos();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  int getStatusIndex(String status) {
    switch (status) {
      case 'Producao': return 1;
      case 'Entrega': return 2;
      case 'Concluido': return 3;
      default: return 1;
    }
  }
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future fetchPedidos() async {
    print('\n\n\n================================================================================\n\t\t\t\tAPP KYOGRE\n===========================================================================================');


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


        } else {
          print('Não possui pedidos ainda hoje');
        }
      }
    } catch (e) {
      print('Erro ao fazer a solicitação GET: $e');
    }
  }



}