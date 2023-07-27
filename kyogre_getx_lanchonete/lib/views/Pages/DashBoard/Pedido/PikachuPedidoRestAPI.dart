
// Modelos de Json para a API do servidor Backend

class AutoGenerate {
  AutoGenerate({
    required this.totalResults,
    required this.totalPages,
    required this.page,
    required this.limit,
    required this.results,
  });
  late final int totalResults;
  late final int totalPages;
  late final int page;
  late final int limit;
  late final List<PedidoCliente> results;

  AutoGenerate.fromJson(Map<String, dynamic> json){
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    page = json['page'];
    limit = json['limit'];
    results = List.from(json['results']).map((e)=>PedidoCliente.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_results'] = totalResults;
    _data['total_pages'] = totalPages;
    _data['page'] = page;
    _data['limit'] = limit;
    _data['results'] = results.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class PedidoCliente {
  PedidoCliente({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.carrinho,
    required this.formaPagamento,
    required this.enderecoCliente,
  });
  late final String? id;
  late final String nome;
  late final String telefone;
  late final Carrinho carrinho;
  late final String formaPagamento;
  late final String enderecoCliente;

  PedidoCliente.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    carrinho = Carrinho.fromJson(json['carrinho']);
    formaPagamento = json['forma_pagamento'];
    enderecoCliente = json['endereco_cliente'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['telefone'] = telefone;
    _data['carrinho'] = carrinho.toJson();
    _data['forma_pagamento'] = formaPagamento;
    _data['endereco_cliente'] = enderecoCliente;
    return _data;
  }
}

class Carrinho {
  Carrinho({
    required this.itensPedido,
    required this.totalPrecoPedido,
  });
  late final List<ItensPedido> itensPedido;
  late final int totalPrecoPedido;

  Carrinho.fromJson(Map<String, dynamic> json){
    itensPedido = List.from(json['itensPedido']).map((e)=>ItensPedido.fromJson(e)).toList();
    totalPrecoPedido = json['totalPrecoPedido'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itensPedido'] = itensPedido.map((e)=>e.toJson()).toList();
    _data['totalPrecoPedido'] = totalPrecoPedido;
    return _data;
  }
}

class ItensPedido {
  ItensPedido({
    required this.nome,
    required this.quantidade,
  });
  late final String nome;
  late final int quantidade;

  ItensPedido.fromJson(Map<String, dynamic> json){
    nome = json['nome'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nome'] = nome;
    _data['quantidade'] = quantidade;
    return _data;
  }
}