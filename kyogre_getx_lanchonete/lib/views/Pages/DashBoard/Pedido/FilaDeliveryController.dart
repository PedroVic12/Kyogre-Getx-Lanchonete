import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';


class FilaDeliveryController extends GetxController {
  // Instanciando o Objeto que recebe o padrao do pedido
  final Fila FILA_PEDIDOS = Fila();

  final controller = Get.find<PedidoController>();


  // Getters
  getFila() => FILA_PEDIDOS;

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



  carregarPedidos(pedidosDoServidor) {


    print('Tamannho Fila Delivery: ${FILA_PEDIDOS.tamanhoFila()}');

    pedidosDoServidor.forEach((pedidosList) {
      final pedido = Pedido.fromJson(pedidosList);

      print("Carregando pedido: ${pedido.id}"); // Adicione esta linha
      if (!FILA_PEDIDOS.contemPedidoComId(pedido.id)) {
        print('Mostrando o alerta..');
        controller.showNovoPedidoAlertDialog(pedidosList);
      }
    });
  }


  void inserirPedido(Pedido pedido) {
    FILA_PEDIDOS.push(pedido);

  }

  Pedido? removerPedido() {
    return FILA_PEDIDOS.pop();
  }





}

//!Models
class No {
  Pedido pedido;
  No? proximo;

  No(this.pedido);
}

class Fila {
  No? inicio;
  No? fim;

  bool get estaVazia => inicio == null;

  int tamanhoFila() {
    int tamanho = 0;
    var atual = inicio;
    while (atual != null) {
      tamanho++;
      atual = atual.proximo;
    }
    return tamanho;
  }

  void push(Pedido pedido) {
    var no = No(pedido);
    if (estaVazia) {
      inicio = fim = no;
    } else {
      fim!.proximo = no;
      fim = no;
    }
  }

  Pedido? pop() {
    if (estaVazia) return null;
    var temp = inicio;
    inicio = inicio!.proximo;
    if (inicio == null) {
      fim = null;
    }
    return temp!.pedido;
  }

  List<Pedido> todosPedidos() {
    List<Pedido> pedidos = [];
    var atual = inicio;
    while (atual != null) {
      pedidos.add(atual.pedido);
      atual = atual.proximo;
    }
    return pedidos;
  }

  bool contemPedidoComId(int id) {
    var atual = inicio;
    while (atual != null) {
      if (atual.pedido.id == id) {
        return true;
      }
      atual = atual.proximo;
    }
    return false;
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

