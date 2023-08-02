import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Produto(this.nome, this.tipo_produto, {this.preco, required this.igredientes});

  void adicionarTamanho(String tamanho, double preco) {
    // Não é mais necessário o campo tamanhos
  }
}

class DataBaseController {
  final String sanduicheTradicionalFile = 'lib/repository/cardapio_1.json';
  final String acaiFile = 'lib/repository/cardapio_2.json';
  final String petiscosFile = 'lib/repository/cardapio_3.json';

  Future<List<Produto>> getAllProducts() async {
    List<Produto> produtos = [];

    produtos.addAll(await getSanduichesTradicionais());
    produtos.addAll(await getAcai());
    produtos.addAll(await getPetiscos());

    return produtos;
  }

  Future<List<Produto>> getSanduichesTradicionais() async {
    try {
      String jsonDados = await rootBundle.loadString(sanduicheTradicionalFile);
      List<dynamic> listaProdutos = jsonDecode(jsonDados);

      return listaProdutos.map((produtoJson) {
        final String nome = produtoJson['Sanduíches Tradicionais'] ?? '';
        final String tipo_produto = 'Sanduíches Tradicionais';
        final String igredientes = produtoJson['Igredientes'] ?? '';
        final Preco preco = Preco.fromJson({
          'preco1': produtoJson['Preço.4']?.toDouble(),
        });
        return Produto(nome, tipo_produto, preco: preco, igredientes: igredientes);
      }).toList();
    } catch (error) {
      print('Erro ao ler o arquivo JSON: $error');
      return [];
    }
  }

  Future<List<Produto>> getAcai() async {
    try {
      String jsonDados = await rootBundle.loadString(acaiFile);
      List<dynamic> listaProdutos = jsonDecode(jsonDados);

      return listaProdutos.map((produtoJson) {
        final String nome = produtoJson['Açaí e Pitaya'] ?? '';
        final String tipo_produto = 'Açaí e Pitaya';
        final String igredientes = ''; // Não há campo "Ingredientes" nos açaís
        final Preco preco = Preco.fromJson({
          'preco1': produtoJson['300ml']?.toDouble(), // Definimos o preço 300ml como preco1
          'preco2': produtoJson['500ml']?.toDouble(), // Definimos o preço 500ml como preco2
        });
        return Produto(nome, tipo_produto, preco: preco, igredientes: igredientes);
      }).toList();
    } catch (error) {
      print('Erro ao ler o arquivo JSON: $error');
      return [];
    }
  }

  Future<List<Produto>> getPetiscos() async {
    try {
      String jsonDados = await rootBundle.loadString(petiscosFile);
      List<dynamic> listaProdutos = jsonDecode(jsonDados);

      return listaProdutos.map((produtoJson) {
        final String nome = produtoJson['Petiscos'] ?? '';
        final String tipo_produto = 'Petiscos';
        final String igredientes = ''; // Não há campo "Ingredientes" nos petiscos
        final Preco preco = Preco.fromJson({
          'preco1': produtoJson['Meia']?.toDouble(), // Definimos o preço da Meia como preco1
          'preco2': produtoJson['Inteira']?.toDouble(), // Definimos o preço da Inteira como preco2
        });
        return Produto(nome, tipo_produto, preco: preco, igredientes: igredientes);
      }).toList();
    } catch (error) {
      print('Erro ao ler o arquivo JSON: $error');
      return [];
    }
  }
}
class ProdutosListView extends StatelessWidget {
  final String categoria;
  final List<Produto> produtos;

  ProdutosListView({required this.categoria, required this.produtos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          categoria,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            Produto produto = produtos[index];
            return ListTile(
              title: Text(produto.nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (produto.preco != null) ...[
                    if (produto.preco!.preco1 != null)
                      Text('Preço 1: R\$ ${produto.preco!.preco1}'),
                    if (produto.preco!.preco2 != null)
                      Text('Preço 2: R\$ ${produto.preco!.preco2}'),
                  ],
                  if (produto.igredientes.isNotEmpty)
                    Text('Ingredientes: ${produto.igredientes}'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
