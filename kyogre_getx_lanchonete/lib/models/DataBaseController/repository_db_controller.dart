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
  final pikachu = PikachuController();

  final dataBase_Array = <List<ProdutoModel>>[].obs;
  bool isLoading = true; // <---- Change this to false after loading data

  Future loadData() async {
    if (isLoading == true) {
      await fetchAllProducts();
      isLoading = false;

      // array 1
      if (dataBase_Array.isNotEmpty) {
        Get.snackbar(
          'Sucesso',
          'Dados REPOSTITORY carregados com sucesso!',
          
          snackPosition: SnackPosition.TOP,
          isDismissible: true
        );
      }

      //array2

      print('\n\n\n DEBUB 7');
      print(dataBase_Array);
    }
    update();
  }

  // Metodos JSON
  Future<List<ProdutoModel>> lerArquivoJson(String filePath) async {
    try {

      final file = File(filePath);
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = json.decode(jsonString);

      // Convertendo o JSON para uma lista de objetos ProdutoModel
      return jsonData
          .map((jsonItem) => ProdutoModel.fromJson(jsonItem))
          .toList();


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

    print('\nDatabase Carregado!');
    isLoading = false;
    return dataBase_Array;
  }

  List<ProdutoModel> filtrarCategoria(String categoriaDesejada) {
    // Filtrar todos os produtos da categoria desejada
    List<ProdutoModel> _produtosFiltrados = [];

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

