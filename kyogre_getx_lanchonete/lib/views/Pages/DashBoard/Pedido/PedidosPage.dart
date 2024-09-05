import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';

class No {
  Pedido pedido;
  No? proximo;

  No(this.pedido);
}

class Fila {
  No? inicio;
  No? fim;

  bool get estaVazia => inicio == null;

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

class PedidosServer extends StatefulWidget {
  const PedidosServer({super.key});

  @override
  _PedidosServerState createState() => _PedidosServerState();
}

class _PedidosServerState extends State<PedidosServer> {
  final Fila fila = Fila();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarPedidos();
    });
  }

  _carregarPedidos() {
    List<Map<String, dynamic>> pedidosDoServidor = [
      {
        "id_pedido": 7581,
        "data": {"data": "30/08/2023", "hora": "22:05:32"},
        "nome": "Pedro",
        "telefone": "5521999289987",
        "endereco": "Niterói",
        "complemento": "Sem Complemento.",
        "formaPagamento": "Sim",
        "pedido": [
          {"quantidade": 1, "nome": "Filé de Carne", "preco": 21.0},
          {"quantidade": 1, "nome": "Provolone a Milanesa", "preco": 24.9}
        ],
        "totalPagar": 45.9
      },
      {
        "id_pedido": 3791,
        "data": {"data": "30/08/2023", "hora": "22:07:53"},
        "nome": "Anakin",
        "telefone": "5521999289987",
        "endereco": "Conselheiro",
        "complemento": "Sem Complemento.",
        "formaPagamento": "Gozada no pé de uma gostosa",
        "pedido": [
          {"quantidade": 1, "nome": "Filé de Carne", "preco": 21.0},
          {"quantidade": 1, "nome": "Provolone a Milanesa", "preco": 24.9}
        ],
        "totalPagar": 45.9
      }
    ];

    for (var pedidosList in pedidosDoServidor) {
      final pedido = Pedido.fromJson(pedidosList);
      print("Carregando pedido: ${pedido.id}"); // Adicione esta linha
      if (!fila.contemPedidoComId(pedido.id)) {
        _mostrarAlertaParaAceitarPedido(pedido);
      }
    }
  }

  _mostrarAlertaParaAceitarPedido(Pedido pedido) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Novo Pedido Recebido"),
        content: Text("Deseja aceitar o pedido de ${pedido.nome_cliente}?"),
        actions: [
          TextButton(
            child: const Text("Recusar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("Aceitar"),
            onPressed: () {
              fila.push(pedido);
              print(
                  "Pedido ${pedido.id} adicionado à fila."); // Adicione esta linha
              setState(() {}); // Atualizar a tela
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Renderizando ${fila.todosPedidos().length} pedidos."); // Adicione esta linha

    return Expanded(
        child: ListView(
      children: fila.todosPedidos().map((pedido) {
        return Card(
          child: ListTile(
            title: Text(pedido.nome_cliente),
            subtitle: Text("Pedido ID: ${pedido.id}"),
          ),
        );
      }).toList(),
    ));
  }
}
