class ProdutoCardapio {
  final int? id;
  final String nome;
  final List<double> preco;
  final String descricao;
  final String? imgUrl;
  final List<String> adicionais;

  ProdutoCardapio({
    this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
    this.imgUrl,
    required this.adicionais,
  });

  factory ProdutoCardapio.fromJson(Map<String, dynamic> json) {
    return ProdutoCardapio(
      id: json['id'],
      nome: json['nome'],
      preco: List<double>.from(json['preco']),
      descricao: json['descricao'],
      imgUrl: json['imgUrl'],
      adicionais: List<String>.from(json['adicionais']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
      'adicionais': adicionais,
    };
  }
}