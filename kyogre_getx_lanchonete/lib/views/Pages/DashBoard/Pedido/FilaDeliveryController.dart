import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';


class FilaDeliveryController extends GetxController {
  // Instanciando o Objeto que recebe o padrao do pedido
  final Fila<Pedido> FILA_PEDIDOS = Fila<Pedido>();

  // Getters
  getFila() => FILA_PEDIDOS;
  Fila<Pedido> get pedidos => FILA_PEDIDOS;

  List array = [];
  bool buscarPedidoNaFila(int pedidoId) {
    for (final pedido in array) {
      if (pedido.id == pedidoId) {
        return true;
      }
    }
    return false;
  }

  void lerPedidosArquivos() {
    // Obter a lista de arquivos json na pasta fila_repository
    List<String> arquivos = Directory('fila_repository').listSync().map((e) => e.path).toList();

    // Ler cada arquivo json e adicionar os pedidos à fila
    for (String arquivo in arquivos) {
      // Ler o arquivo json
      Map<String, dynamic> json = jsonDecode(File(arquivo).readAsStringSync());

      // Criar um pedido a partir do json
      Pedido pedido = Pedido.fromJson(json);

      // Adicionar o pedido à fila
      FILA_PEDIDOS.push(pedido);
    }
  }

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

  List<Pedido> getAllPedidos() {
    List<Pedido> pedidos = [];

    // Iterar sobre a fila usando o tamanho da fila
    for (var i = 0; i < FILA_PEDIDOS.size; i++) {
      pedidos.add(FILA_PEDIDOS[i]!);
    }

    return pedidos;
  }


  void inserirPedido(Pedido pedido) {
    FILA_PEDIDOS.push(pedido);

  }

  Pedido? removerPedido() {
    return FILA_PEDIDOS.pop();
  }
  bool verificarPedidoNaFila(int pedidoId) {
    return buscarPedidoPorId(pedidoId);
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

  Iterable<T> iterator() {
    return [data];
  }
}

class Fila<T> {
  No<T>? first;
  No<T>? last;
  int size = 0;
  No<T>? _fila;

  Iterable<T> get items sync* {
    No<T>? current = first;
    while (current != null) {
      yield current.data;
      current = current.next;
    }
  }




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

  Pedido? operator [](int index) {
    if (index < 0 || index >= size) {
      return null;
    }

    No<Pedido>? current = first as No<Pedido>?;
    for (var i = 0; i < index; i++) {
      current = current!.next;
    }

    return current!.data;
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



void main() {
  // Instanciar o controller
  final controller = FilaDeliveryController();

  // Ler os pedidos dos arquivos json
  controller.lerPedidosArquivos();
  print(controller.FILA_PEDIDOS);

  List array_pedidos = [];

  // Iterar sobre os pedidos
  for (Pedido pedido in array_pedidos) {
    // Perguntar se o usuário deseja aceitar o pedido
    print('Deseja aceitar o pedido de ${pedido.nome}? (1 - Sim, 2 - Não)');
    String? resposta = stdin.readLineSync();

    // Se a resposta for 1, aceitar o pedido
    if (resposta == '1') {
      controller.inserirPedido(pedido);
    }
  }

  // Buscar um pedido na fila pelo ID
  final pedidoEncontrado = controller.buscarPedidoNaFila(1);
  print('Pedido encontrado: ${pedidoEncontrado}');

  // Remover um pedido da fila
  final pedidoRemovido = controller.removerPedido();
  print('Pedido removido: ${pedidoRemovido}');


}

