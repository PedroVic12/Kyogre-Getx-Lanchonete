import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart'; // Importe a biblioteca 'dart:io' para lidar com arquivos

class Produto {
  final int id;
  final String nome;
  final double preco;
  final String imageUrl;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imageUrl,
  });
}

class DataBaseController {
  final Map<String, List<Produto>> categorias = {
    'Bebidas': [],
    'Comidas': [],
    'Açai': [],
    'Pizzas': [],
    'Pratos': [],
    'SanduichesNaturais': [],
  };

  int get categoriasLength => categorias.length;

  // Métodos para ler o JSON
  List<Produto> lerAcai(List<dynamic> listaJson) {
    List<Produto> produtos = listaJson.map((json) {
      return Produto(
        id: json['id'],
        nome: json['Açaí e Pitaya'],
        preco: json['500ml'] ?? 0.0,
        imageUrl: '', // Preencher aqui com a URL da imagem do açaí, se houver
      );
    }).toList();

    return produtos;
  }

  List<Produto> lerSanduiches(List<dynamic> listaJson) {
    List<Produto> produtos = listaJson.map((json) {
      return Produto(
        id: json['id'],
        nome: json['Sanduíches Tradicionais'],
        preco: json['Preço.4'] ?? 0.0,
        imageUrl: json['imagem'] ?? '',
      );
    }).toList();

    return produtos;
  }

  //! Métodos que retornas os dados lidos
  List<Produto> getAcai() {
    const acai_file = 'lib/repository/cardapio_2.json';
    try {
      String jsonDados = File(acai_file).readAsStringSync();
      List<dynamic> listaJson = jsonDecode(jsonDados);

      return categorias['Acai'] ??= lerAcai(listaJson);
    } catch (e) {
      print('Erro ao ler o arquivo JSON de Açaí: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  List<Produto> getSanduiches() {
    const sanduiche_file = 'lib/repository/cardapio_2.json';
    try {
      String jsonDados = File(sanduiche_file).readAsStringSync();
      List<dynamic> listaJson = jsonDecode(jsonDados);

      return categorias['Sanduiches'] ??= lerSanduiches(listaJson);
    } catch (e) {
      print('Erro ao ler o arquivo JSON de Sanduiches: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

// Implemente outras funções get para as demais categorias se necessário...
}
class JSONListView extends StatelessWidget {
  final DataBaseController dataBaseController = DataBaseController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: dataBaseController.categorias['Acai']?.length ?? 0,
            itemBuilder: (context, index) {
              Produto produto = dataBaseController.categorias['Acai']![index];
              return ListTile(
                title: Text(produto.nome),
                subtitle: Text('Preço: R\$ ${produto.preco}'),
                leading: CircleAvatar(
                  //backgroundImage: NetworkImage(produto.imageUrl),
                  backgroundColor: Colors.blue,
                ),
              );
            },
          ),
        ),
        // Você pode criar mais ListViews para as demais categorias, se necessário...
      ],
    );
  }
}