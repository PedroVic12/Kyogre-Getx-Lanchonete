

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

  Produto(this.nome, this.tipo_produto, {this.preco, required this.igredientes});

}



class ProdutoModel {
  String nome;
  List<Map<String, dynamic>> precos;
  List<String>? ingredientes;
  String? imagem;
  String categoria;

  ProdutoModel({
    required this.nome,
    required this.precos,
    this.ingredientes,
    this.imagem,
    required this.categoria,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'categoria': categoria,
      'precos': precos,
      'ingredientes': ingredientes,
      'imagem': imagem
    };
  }

  // Factory constructor para converter JSON em um objeto ProdutoModel
  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      nome: json['nome'],
      categoria: json['categoria'],
      precos: _extrairPrecos(json),
      ingredientes: json['ingredientes']?.cast<String>(),
      imagem: json['imagem'],
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