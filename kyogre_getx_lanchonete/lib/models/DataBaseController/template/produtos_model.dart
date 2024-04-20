class Preco {
  final double? preco1;
  final double? preco2;

  Preco({this.preco1, this.preco2});

  factory Preco.fromJson(Map<String, dynamic> json) {
    return Preco(
      preco1: json['preco1']?.toDouble(),
      preco2: json['preco2']?.toDouble(),
    );
  }
}

class Produto {
  final String nome;
  final String tipo_produto;
  Preco? preco;
  late final String igredientes;
  late final String image_url;

  Produto(this.nome, this.tipo_produto,
      {this.preco, required this.igredientes});
}

class ProdutoModel {
  String nome;
  String categoria;
  double preco_1;
  String? sub_categoria;
  double? preco_2;
  String? ingredientes;
  String? imagem;
  Map? Adicionais;

  ProdutoModel({
    required this.nome,
    required this.preco_1,
    required this.categoria,
    this.sub_categoria,
    this.preco_2,
    this.ingredientes,
    this.imagem,
    this.Adicionais,
  });
  ProdutoModel copyWith({
    String? nome,
    double? preco_1,
    String? ingredientes,
    String? sub_categoria,
    String? categoria,
    Map<String, double>? Adicionais,
  }) {
    return ProdutoModel(
      nome: nome ?? this.nome,
      preco_1: preco_1 ?? this.preco_1,
      ingredientes: ingredientes ?? this.ingredientes,
      sub_categoria: sub_categoria ?? this.sub_categoria,
      categoria: categoria ?? this.categoria,
      Adicionais: Adicionais ?? this.Adicionais,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'categoria': categoria,
      'preco_1': preco_1,
      'preco_2': preco_2,
      'ingredientes': ingredientes,
      'imagem': imagem,
      "sub_categoria": sub_categoria,
    };
  }

  // Factory constructor para converter JSON em um objeto ProdutoModel
  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      nome: json['NOME'],
      categoria: json['CATEGORIA'],
      preco_1: json['preco_1'],
      preco_2: json['preco_2'],
      sub_categoria: json["SUB_CAT"],
      ingredientes: json['IGREDIENTES'],
      imagem: json['IMAGEM'],
    );
  }

  // Função privada para extrair preços de um JSON
  static List<Map<String, dynamic>> _extrairPrecos(Map<String, dynamic> json) {
    var precos = <Map<String, dynamic>>[];
    json['precos']?.forEach((preco) {
      precos.add({
        'preco': preco['preco_1'] ?? 0.0,
        'descricao': preco['descricao'] ?? '',
      });
    });
    return precos;
  }
}
