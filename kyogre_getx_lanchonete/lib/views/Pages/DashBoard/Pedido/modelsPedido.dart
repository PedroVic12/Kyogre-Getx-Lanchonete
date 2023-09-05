
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
    print('Adicionando pedido: $pedido');
    var no = No(pedido);
    if (estaVazia) {
      inicio = fim = no;
    } else {
      fim!.proximo = no;
      fim = no;
    }
  }

  List<Pedido> todosPedidos() {
    List<Pedido> pedidos_array = [];
    var atual = inicio;
    while (atual != null) {
      print('Adicionando pedido à lista: ${atual.pedido}');
      pedidos_array.add(atual.pedido);
      atual = atual.proximo;
    }
    print('Retornando lista de pedidos com tamanho: ${pedidos_array.length}');
    return pedidos_array;
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

