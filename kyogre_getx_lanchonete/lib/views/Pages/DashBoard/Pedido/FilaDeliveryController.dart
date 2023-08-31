import 'package:get/get.dart';


class FilaDeliveryController extends GetxController {
  final Fila<Pedido> FILA_PEDIDOS = Fila<Pedido>();

  getFila() => FILA_PEDIDOS;

  bool todosPedidosNaFila(pedidos) {
    for (final pedido in pedidos) {
      final pedidoId = pedido['id_pedido'];

      // Convert pedidoId to an integer
      final intPedidoId = int.tryParse(pedidoId);

      if (intPedidoId != null && !buscarPedidoPorId(intPedidoId)) {
        return false;
      }
    }
    return true;
  }

  void inserirPedido(Pedido pedido) {
    FILA_PEDIDOS.push(pedido);

  }

  Pedido? removerPedido() {
    return FILA_PEDIDOS.pop();
  }

  bool buscarPedidoPorId(int pedidoId) {
    No<Pedido>? current = FILA_PEDIDOS.first;
    while (current != null) {
      if (current.data.id == pedidoId) {
        return true;
      }
      current = current.next;
    }
    return false;
  }


}

//!Models
class No<T> {
  T data;
  No<T>? next;

  No(this.data);
}

class Fila<T> {
  No<T>? first;
  No<T>? last;
  int size = 0;

  void push(T elemento) {
    No<T> node = No(elemento);

    if (last == null) {
      last = node;
    } else {
      last!.next = node;
      last = node;
    }

    if (first == null) {
      first = node;
    }

    size++;
  }

  T? peek() {
    if (empty()) {
      return null;
    }
    return first!.data;
  }

  T? pop() {
    if (empty()) {
      return null;
    }
    T elemento = first!.data;
    first = first!.next;

    if (first == null) {
      last = null;
    }

    size--;
    return elemento;
  }

  int get length => size;

  bool empty() {
    return size == 0;
  }

  String showData() {
    if (empty()) {
      return 'Fila Vazia, sem pedidos por enquanto';
    }

    String s = '';
    No<T>? current = first;
    while (current != null) {
      s += current.data.toString();
      current = current.next;
      if (current != null) {
        s += ' -> ';
      }
    }
    return s;
  }
}

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
