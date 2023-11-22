import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

class RepositoryDataBaseController extends GetxController {
  // Variaveis
  final String acaiFile = 'lib/repository/cardapio_2.json';
  final String petiscosFile = 'lib/repository/cardapio_3.json';

  final String sanduicheFile ='lib/models/DataBaseController/models/sanduiches.json';
  final String hamburguersFile = 'lib/models/DataBaseController/models/hamburguer.json';
  final String pizzasFile = 'lib/models/DataBaseController/models/pizzas.json';

  List<List<ProdutoModel>> dataBase_Array = [];
  bool isLoading = true; // <---- Change this to false after loading data

  Future loadData() async {
    // Garantir que os produtos estão carregados
    if (isLoading == true) {
      await fetchAllProducts();
      isLoading = false;
    }
    update();
  }

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

    dataBase_Array.add(await lerArquivoJson(pizzasFile));
    dataBase_Array.add(await lerArquivoJson(hamburguersFile));
    dataBase_Array.add(await lerArquivoJson(sanduicheFile));


    // dataBase_Array.add(await lerArquivoJson(acaiFile));
    // dataBase_Array.add(await lerArquivoJson(petiscosFile));

    print('Database carregado!');
    isLoading = false;
    return dataBase_Array;
  }

  List<ProdutoModel> filtrarCategoria(String categoriaDesejada)  {
    // Filtrar todos os produtos da categoria desejada
    List<ProdutoModel> _produtosFiltrados =  [];

    _produtosFiltrados = dataBase_Array
        .expand((lista) => lista)
        .where((produto) => produto.categoria == categoriaDesejada)
        .toList();

    return _produtosFiltrados;
  }

  void ordenarPorNome(List<ProdutoModel> produtos) {
    produtos.sort((a, b) => a.nome.compareTo(b.nome));
  }

  String get dataBaseArrayJson {
    return jsonEncode(dataBase_Array.map((lista) => lista.map((produto) => produto.toJson()).toList()).toList());
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
