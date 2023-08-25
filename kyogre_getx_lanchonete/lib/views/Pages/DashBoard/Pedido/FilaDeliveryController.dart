import 'package:get/get.dart';

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