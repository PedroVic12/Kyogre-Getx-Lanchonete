import 'dart:collection';

import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class Pedido {
  final int id;
  final Map<String, dynamic> data;
  final String nome;
  final String telefone;
  final String endereco;
  final String complemento;
  final String formaPagamento;
  final List<Map<String, dynamic>> itensPedido;
  final double totalPagar;

  Pedido({
    required this.id,
    required this.data,
    required this.nome,
    required this.telefone,
    required this.endereco,
    required this.complemento,
    required this.formaPagamento,
    required this.itensPedido,
    required this.totalPagar,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id_pedido'],
      data: json['data'],
      nome: json['nome'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      complemento: json['complemento'],
      formaPagamento: json['formaPagamento'],
      itensPedido: List<Map<String, dynamic>>.from(json['pedido']),
      totalPagar: json['totalPagar'],
    );
  }
}


class FilaDeliveryController extends GetxController {
  //final pedidoController = Get.put(PedidoController());


  final FILA_PEDIDOS = Rx<Queue<Pedido>>(Queue());

  List<Pedido> get filaPedidos => FILA_PEDIDOS.value.toList();

  void inserirPedido(Pedido pedido) {
    if (!buscarPedido(pedido)) { // Verifique se o pedido já não está na fila
      FILA_PEDIDOS.value.add(pedido);
    }
  }

  Pedido? removerPedido() {
    if (FILA_PEDIDOS.value.isNotEmpty) {
      final pedido = FILA_PEDIDOS.value.removeFirst();
      return pedido;
    }
    return null;
  }

  bool buscarPedido(Pedido pedido) {
    //final array = pedidoController.PEDIDOS_ACEITOS_ARRAY;
    //print(array);



    return FILA_PEDIDOS.value.any((filaPedido) => filaPedido.id == pedido.id);
  }
}
