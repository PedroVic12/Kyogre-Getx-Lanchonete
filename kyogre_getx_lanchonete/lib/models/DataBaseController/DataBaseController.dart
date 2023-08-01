import 'dart:convert';
import 'package:flutter/services.dart';

import 'Produtos/Produto.dart';

class DataBaseController {
  Future<List<Produto>> getCardapio(String fileName) async {
    String jsonDados = await rootBundle.loadString('assets/$fileName');
    List<Produto> produtos = parseProdutos(jsonDados);
    return produtos;
  }

  List<Produto> parseProdutos(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Produto>((json) => Produto(
      categoria: json.keys.first,
      ingredientes: json['Igredientes'],
      preco: json['Preço.4'],
      imagemUrl: json['imagem'] ?? '',
    )).toList();
  }
}
