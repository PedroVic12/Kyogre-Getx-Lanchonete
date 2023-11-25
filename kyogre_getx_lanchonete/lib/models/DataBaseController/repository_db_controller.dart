// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

import '../../views/Pages/Tela Cardapio Digital/controllers/pikachu_controller.dart';

class RepositoryDataBaseController extends GetxController {
  final String sanduicheFile = 'lib/repository/models/sanduiches.json';
  final String hamburguersFile = 'lib/repository/models/hamburguer.json';
  final String pizzasFile = 'lib/repository/models/pizzas.json';
  final PikachuController pikachu = Get.put(PikachuController());

  final dataBase_Array = <List<ProdutoModel>>[].obs;
  final List my_array = [].obs;

  bool isLoading = true; // <---- Change this to false after loading data

  Future loadData() async {
    if (isLoading == true) {
      await fetchAllProducts();
      isLoading = false;
    }
    update();
  }

  Future carregandoDadosRepository(file) async {
    isLoading = true;

    // Limpa o array existente
    my_array.clear();

    try {
      // Simulando uma chamada de rede para buscar dados do Pikachu
      await Future.delayed(Duration(seconds: 2));

      // Le dados json file
      final String response = await rootBundle.loadString(file);
      final dados = await json.decode(response);

      pikachu.cout(dados);
      List produtos = dados.map((item) => ProdutoModel.fromJson(item)).toList();

      for (var index = 0; index < produtos.length; index++) {
        //pikachu.cout('${index} = ${produtos[index].nome} | ${produtos[index].categoria}' );
        my_array.add(produtos[index]);
      }
    } catch (e) {
      pikachu.cout('ERRO ao carregar dados: $e');
    } finally {
      isLoading = false;
    }
    return my_array;
  }

  // Metodos JSON
  Future<List<ProdutoModel>> lerArquivoJson(String filePath) async {
    try {
      final String response = await rootBundle.loadString(filePath);
      final List<dynamic> jsonData = await json.decode(response);

      // Convertendo o JSON para uma lista de objetos ProdutoModel
      var _produto =
          jsonData.map((jsonItem) => ProdutoModel.fromJson(jsonItem)).toList();

      pikachu.cout(_produto);

      return _produto;
    } catch (e) {
      print('\n\nErro ao carregar Produtos JSON do DataBase: $e');
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

    isLoading = false;
    return dataBase_Array;
  }

  List<ProdutoModel> filtrarCategoria(String categoriaDesejada) {
    // Filtrar todos os produtos da categoria desejada
    List<ProdutoModel> _produtosFiltrados = [];

    //TODO TROCAR PARA O ARRAY CORRETO
    _produtosFiltrados = dataBase_Array
        .expand((lista) => lista)
        .where((produto) => produto.categoria == categoriaDesejada)
        .toList();

    return _produtosFiltrados;
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
