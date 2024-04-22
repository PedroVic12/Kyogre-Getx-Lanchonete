import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

void main() {
  var hamburguer = [
    {
      'nome': 'X- Tudo',
      'categoria': 'Hamburguer',
      'precos': [
        {'preco_1': 10.0, 'descricao': 'P'},
        {'preco_2': 15.0, 'descricao': 'M'},
      ],
      'ingredientes': [
        'pao',
        'carne',
        'queijo',
        'alface',
        'tomate',
        'cebola',
        'molho especial'
      ],
      'imagem': 'img_url'
    },
    {
      'nome': 'Double Cheese',
      'categoria': 'Hamburguer',
      'precos': [
        {'preco_1': 10.0, 'descricao': 'P'},
        {'preco_2': 0, 'descricao': 'M'},
      ],
      'ingredientes': [
        'pao',
        'carne',
        'queijo',
        'alface',
        'tomate',
        'cebola',
        'molho especial'
      ],
      'imagem': 'img_url'
    }
  ];

  var pizza_object = [
    {
      'nome': 'Pizza Calabresa',
      'categoria': 'Pizza',
      'precos': [
        {'preco_1': 40.0, 'descricao': 'P'},
        {'preco_2': 55.0, 'descricao': 'M'},
      ],
      'ingredientes': [
        'queijo',
        'alface',
        'tomate',
        'cebola',
        'molho especial'
      ],
      'imagem': 'img_url'
    },
    {
      'nome': 'Pizza Portuguesa',
      'categoria': 'Pizza',
      'precos': [
        {'preco_1': 40.0, 'descricao': 'P'},
        {'preco_2': 55.0, 'descricao': 'M'},
      ],
      'ingredientes': [
        'queijo',
        'alface',
        'tomate',
        'cebola',
        'molho especial'
      ],
      'imagem': 'img_url'
    },
  ];

  List<ProdutoModel> produtos =
      pizza_object.map((json) => ProdutoModel.fromJson(json)).toList();

  // Exemplo de uso dos produtos
  for (var produto in produtos) {
    print(produto.categoria);
    print('\nProduto: ${produto.nome}');
  }
}
