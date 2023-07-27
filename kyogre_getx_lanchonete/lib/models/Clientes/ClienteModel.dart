import 'dart:convert';
import 'package:flutter/cupertino.dart';

class UsersClientes {
  final List<DadosPedido> data;

  UsersClientes({required this.data});

  factory UsersClientes.fromJson(Map<String, dynamic> json) {
    return UsersClientes(
      data: List<DadosPedido>.from(
          json['data'].map((x) => DadosPedido.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((e) => e.toJson())),
  };
}

class DadosPedido {
  final int id;
  final String itens_pedido;
  final String nome_cliente;
  final int telefone;
  final String forma_pagamento;
  final double preco_total;
  final String endereco_entrega;

  DadosPedido({
    required this.id,
    required this.nome_cliente,
    required this.itens_pedido,
    required this.telefone,
    required this.forma_pagamento,
    required this.preco_total,
    required this.endereco_entrega,
  });

  factory DadosPedido.fromJson(Map<String, dynamic> json) {
    return DadosPedido(
      id: json['id'],
      nome_cliente: json["nome_cliente"],
      itens_pedido: json['itens_pedido'],
      telefone: json['telefone'],
      forma_pagamento: json['forma_pagamento'],
      preco_total: json['preco_total'],
      endereco_entrega: json['endereco_entrega'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome_cliente': nome_cliente,
    'itens_pedido': itens_pedido,
    'telefone': telefone,
    'forma_pagamento': forma_pagamento,
    'preco_total': preco_total,
    'endereco_entrega': endereco_entrega,
  };
}
