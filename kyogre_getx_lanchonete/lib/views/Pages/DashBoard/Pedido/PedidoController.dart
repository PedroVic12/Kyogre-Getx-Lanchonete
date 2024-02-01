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

  Future<void> atualizarStatusPedidoServer(int pedidoId, String acao) async {
    final url = Uri.parse('https://rayquaza-citta-server.onrender.com/pedidos/$pedidoId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': pedidoId, 'acao': acao}),
    );

    if (response.statusCode == 200) {
      print('Pedido atualizado com sucesso.');
    } else {
      print('Falha ao atualizar o pedido: ${response.body}');
    }
  }
  // Atualiza o status do pedido com base no index e move para a coluna correspondente
  void atualizarStatusPedido(int id, int novoIndex) {
    var pedido = filaDeliveryController.getTodosPedidos().where((pedido) => pedido.id == id).toList();
    pedido[0].status = getIndexStatus(novoIndex);
    update();
  }



  Future<void> avancarPedido(int id) async {
    var pedido = filaDeliveryController.getTodosPedidos().where((pedido) => pedido.id == id).toList();
    pikachu.cout("TESTE = ${pedido[0].id} - ${pedido[0].status} ");
    if (pedido != null) {
      var novoIndex = getStatusIndex(pedido[0].status) + 1;
      if (novoIndex <= 3) {
        //await atualizarStatusPedidoServer(id, "push");
        atualizarStatusPedido(pedido[0].id,novoIndex);
        update();
      }
    }
  }

  Future<void> retrocederPedido(int id) async {
    var pedido = filaDeliveryController.getTodosPedidos().where((pedido) => pedido.id == id).toList();
    try{
      if (pedido != null) {
        var novoIndex = getStatusIndex(pedido[0].status) - 1;
        if (novoIndex >= 1) {
          //await atualizarStatusPedidoServer(id, "pull");
          atualizarStatusPedido(pedido[0].id,novoIndex);
          update();
        }
      }
    }catch (e){
      Get.snackbar('Erro', e.toString());
    }

  }


  int getStatusIndex(String status) {
    switch (status) {
      case 'Producao':
        return 1;
      case 'Entrega':
        return 2;
      case 'Concluido':
        return 3;
      default:
        return 1;
    }
  }

  String getIndexStatus(int index) {
    switch (index) {
      case 1:
        return 'Producao';
      case 2:
        return 'Entrega';
      case 3:
        return 'Concluido';
      default:
        return 'Producao';
    }
  }









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

  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future fetchPedidos() async {
    print('\n\n\n=================================================\n\t\t\t\tAPP KYOGRE\n===========================================================================================');


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