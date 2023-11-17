import 'dart:convert';
import 'dart:io';

import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

class RepositoryDataBaseController {

  // Variaveis
  final String sanduicheTradicionalFile = 'lib/repository/cardapio_1.json';
  final String acaiFile = 'lib/repository/cardapio_2.json';
  final String petiscosFile = 'lib/repository/cardapio_3.json';

  final String hamburguersFile = 'lib/models/DataBaseController/models/hamburguer.json';
  final String pizzasFile = 'lib/models/DataBaseController/models/pizzas.json';

  List<List<ProdutoModel>> dataBase_Array = [];
  bool isLoading = false;

  // Metodos JSON
  Future<List<ProdutoModel>> lerArquivoJson(String filePath) async {
    try {
      final file = File(filePath);
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData.map((jsonItem) => ProdutoModel.fromJson(jsonItem)).toList();
    } catch (e) {
      print('Erro ao ler o arquivo JSON: $e');
      return [];
    }
  }

  // All Database
  Future<List<List<ProdutoModel>>> fetchAllProducts() async {
    dataBase_Array.clear();

    dataBase_Array.add(await lerArquivoJson(hamburguersFile));
    dataBase_Array.add(await lerArquivoJson(pizzasFile));

    // dataBase_Array.add(await lerArquivoJson(sanduicheTradicionalFile));
    // dataBase_Array.add(await lerArquivoJson(acaiFile));
    // dataBase_Array.add(await lerArquivoJson(petiscosFile));

    isLoading = true;
    print('Database carregado!');
    return dataBase_Array;
  }

  String get dataBaseArrayJson {
    return jsonEncode(dataBase_Array.map((lista) => lista.map((produto) => produto.toJson()).toList()).toList());
  }

  Future<List<ProdutoModel>> filtrarCategoria(String categoriaDesejada) async {
    // Garantir que os produtos estão carregados
    if (!isLoading) {
      await fetchAllProducts();
    }


    // Filtrar todos os produtos da categoria desejada
    List<ProdutoModel> produtosFiltrados = dataBase_Array
        .expand((lista) => lista)
        .where((produto) => produto.categoria == categoriaDesejada)
        .toList();

    return produtosFiltrados;
  }


  void ordenarPorNome(List<ProdutoModel> produtos) {
    produtos.sort((a, b) => a.nome.compareTo(b.nome));
  }














  String formatarProdutosArray(List<List<ProdutoModel>> dataBase_Array) {
    return dataBase_Array.expand((lista) => lista).map((produto) {
      return 'Produto: ${produto.nome}, Categoria: ${produto.categoria}, Preços: ${produto.precos.map((p) => '${p['descricao']}: ${p['preco']}').join(', ')}, Ingredientes: ${produto.ingredientes?.join(', ') ?? 'N/A'}, Imagem: ${produto.imagem ?? 'N/A'}';
    }).join('\n');
  }

  String formatarProduto(ProdutoModel produto) {
    return 'Produto: ${produto.nome}, Categoria: ${produto.categoria}, Preços: ${produto.precos.map((p) => '${p['descricao']}: ${p['preco']}').join(', ')}, Ingredientes: ${produto.ingredientes?.join(', ') ?? 'N/A'}, Imagem: ${produto.imagem ?? 'N/A'}';
  }


}
