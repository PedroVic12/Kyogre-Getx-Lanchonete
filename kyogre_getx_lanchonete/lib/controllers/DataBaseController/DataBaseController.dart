import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/template/produtos_model.dart';

class DataBaseController {
  final String sanduicheTradicionalFile = 'lib/repository/cardapio_1.json';
  final String acaiFile = 'lib/repository/cardapio_2.json';
  final String petiscosFile = 'lib/repository/cardapio_3.json';

  List<Produto> produtos_loja = [];

  Future<List<Produto>> getAllProducts() async {
    produtos_loja.addAll(await getSanduichesTradicionais());
    produtos_loja.addAll(await getAcai());
    produtos_loja.addAll(await getPetiscos());

    return produtos_loja;
  }

  Future<List<Produto>> getSanduichesTradicionais() async {
    try {
      String jsonDados = await rootBundle.loadString(sanduicheTradicionalFile);
      List<dynamic> listaProdutos = jsonDecode(jsonDados);

      return listaProdutos.map((produtoJson) {
        final String nome = produtoJson['Sanduíches'] ?? '';
        const String tipoProduto = 'Sanduíches';
        final String igredientes = produtoJson['Igredientes'] ?? '';
        final Preco preco = Preco.fromJson({
          'preco1': produtoJson['Preço.4']?.toDouble(),
        });
        return Produto(nome, tipoProduto,
            preco: preco, igredientes: igredientes);
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
        const String tipoProduto = 'Açaí e Pitaya';
        const String igredientes = ''; // Não há campo "Ingredientes" nos açaís
        final Preco preco = Preco.fromJson({
          'preco1': produtoJson['300ml']
              ?.toDouble(), // Definimos o preço 300ml como preco1
          'preco2': produtoJson['500ml']
              ?.toDouble(), // Definimos o preço 500ml como preco2
        });
        return Produto(nome, tipoProduto,
            preco: preco, igredientes: igredientes);
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
        const String tipoProduto = 'Petiscos';
        const String igredientes =
            ''; // Não há campo "Ingredientes" nos petiscos
        final Preco preco = Preco.fromJson({
          'preco1': produtoJson['Meia']
              ?.toDouble(), // Definimos o preço da Meia como preco1
          'preco2': produtoJson['Inteira']
              ?.toDouble(), // Definimos o preço da Inteira como preco2
        });
        return Produto(nome, tipoProduto,
            preco: preco, igredientes: igredientes);
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

  const ProdutosListView(
      {super.key, required this.categoria, required this.produtos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          categoria,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
