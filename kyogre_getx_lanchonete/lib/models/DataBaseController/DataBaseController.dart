import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Produto {
  final String nome;
  final String tipoProduto;
  Map<String, double>? tamanhos;

  Produto(this.nome, this.tipoProduto);

  void adicionarTamanho(String tamanho, double preco) {
    tamanhos ??= {};
    tamanhos![tamanho] = preco;
  }
}

class DataBaseController {
  final String sanduicheTradicionalFile = 'lib/repository/cardapio_1.json';
  final String acaiFile = 'lib/repository/cardapio_2.json';
  final String petiscosFile = 'lib/repository/cardapio_3.json';

  Future<List<Produto>> getSanduichesTradicionais() async {
    try {
      String jsonDados = await rootBundle.loadString(sanduicheTradicionalFile);
      List<dynamic> listaProdutos = jsonDecode(jsonDados);

      return listaProdutos.map((produtoJson) {
        final String nome = produtoJson['Sanduíches Tradicionais'] ?? '';
        final String tipoProduto = 'Sanduíches Tradicionais';
        final double? preco = produtoJson['Preço.4']?.toDouble();
        final produto = Produto(nome, tipoProduto);
        produto.adicionarTamanho('Preço', preco ?? 0.0);
        return produto;
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
        final String tipoProduto = 'Açaí e Pitaya';
        final double? preco300ml = produtoJson['300ml']?.toDouble();
        final double? preco500ml = produtoJson['500ml']?.toDouble();
        final produto = Produto(nome, tipoProduto);
        if (preco300ml != null) {
          produto.adicionarTamanho('300ml', preco300ml);
        }
        if (preco500ml != null) {
          produto.adicionarTamanho('500ml', preco500ml);
        }
        return produto;
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
        final String tipoProduto = 'Petiscos';
        final double? precoMeia = produtoJson['Meia']?.toDouble();
        final double? precoInteira = produtoJson['Inteira']?.toDouble();
        final produto = Produto(nome, tipoProduto);
        if (precoMeia != null) {
          produto.adicionarTamanho('Meia', precoMeia);
        }
        if (precoInteira != null) {
          produto.adicionarTamanho('Inteira', precoInteira);
        }
        return produto;
      }).toList();
    } catch (error) {
      print('Erro ao ler o arquivo JSON: $error');
      return [];
    }
  }
}

class ProdutosListView extends StatelessWidget {
  final List<Produto> produtos;

  ProdutosListView({required this.produtos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto produto = produtos[index];
        return ListTile(
          title: Text(produto.nome),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (produto.tamanhos != null) ...[
                for (var tamanho in produto.tamanhos!.keys)
                  Text('Preço $tamanho: R\$ ${produto.tamanhos![tamanho]}'),
              ],

            ],
          ),
        );
      },
    );
  }
}

void main_db_controller() async {
  final db = DataBaseController();

  List<Produto> sanduiches = await db.getSanduichesTradicionais();
  List<Produto> acais = await db.getAcai();
  List<Produto> petiscos = await db.getPetiscos();

  print('Sanduíches Tradicionais:');
  sanduiches.forEach((produto) {
    print('${produto.nome}, ${produto.tipoProduto}, Preço: ${produto.tamanhos?['Preço'] ?? 'Indisponível'}');
  });

  print('Açaí e Pitaya:');
  acais.forEach((produto) {
    print('${produto.nome}, ${produto.tipoProduto}, Preço 300ml: ${produto.tamanhos?['300ml'] ?? 'Indisponível'}, Preço 500ml: ${produto.tamanhos?['500ml'] ?? 'Indisponível'}');
  });

  print('Petiscos:');
  petiscos.forEach((produto) {
    print('${produto.nome}, ${produto.tipoProduto}, Meia: ${produto.tamanhos?['Meia'] ?? 'Indisponível'}, Inteira: ${produto.tamanhos?['Inteira'] ?? 'Indisponível'}');
  });
}

void main() {
  main_db_controller();
}
