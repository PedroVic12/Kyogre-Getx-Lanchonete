import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class CardapioModel {
  final String id;
  final String nome;
  final String categoria;
  final String subCategoria;
  final double preco1;
  final double preco2;
  final String ingredientes;
  final List<String> imagens;

  CardapioModel({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.subCategoria,
    required this.preco1,
    required this.preco2,
    required this.ingredientes,
    required this.imagens,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'NOME': nome,
      'CATEGORIA': categoria,
      'SUB_CAT': subCategoria,
      'preco_1': preco1,
      'preco_2': preco2,
      'IGREDIENTES': ingredientes,
      'IMAGEM': imagens.join(' | '), // Concatena as imagens separadas por '|'
    };
  }

  factory CardapioModel.fromJson(Map<String, dynamic> item) {
    List<String> imagens = (item['IMAGEM'] as String).split(' | ');
    return CardapioModel(
      id: item['_id'],
      nome: item['NOME'],
      categoria: item['CATEGORIA'],
      subCategoria: item['SUB_CAT'] ?? '',
      preco1: item['preco_1'].toDouble(),
      preco2: item['preco_2'],
      ingredientes: item['IGREDIENTES'],
      imagens: imagens,
    );
  }
}

class MongoServiceDB extends GetxController {
  var isLoading = true.obs;
  List<CardapioModel> products =
      <CardapioModel>[].obs; // Defina o tipo como List<CardapioModel>
  final dio = Dio();
  List<Map<String, dynamic>> productsMongo = <Map<String, dynamic>>[].obs;

  String apiUrl = 'http://0.0.0.0:7070'; // Change this to your API URL

  getDatabases() async {
    var response = await dio.get("$apiUrl/databases");
    return response.data["databases"];
  }

  Future<List<String>> getCategorias(String databaseName) async {
    try {
      var response = await dio.get("$apiUrl/collections/$databaseName");

      // Verifica se a resposta foi bem-sucedida
      if (response.statusCode == 200) {
        // Retorna a lista de coleções (categorias)
        List<dynamic> collections = response.data["collections"];
        return collections.map((collection) => collection.toString()).toList();
      } else {
        // Lida com uma resposta de erro
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      // Lida com exceções que podem ocorrer durante a execução da requisição
      print('Error loading categories: $e');
      throw Exception('Failed to load categories: $e');
    }
  }

  fetchProducts() async {
    try {
      var response = await dio.get("$apiUrl/homeMongo");
      if (response.statusCode == 200) {
        print("\n\nDados SQL= ${response.data}");

        // Limpa a lista de produtos antes de adicionar os novos
        productsMongo.clear();

        // Adiciona cada produto individualmente à lista
        for (var item in response.data) {
          productsMongo.add(item);
        }
        isLoading.value = false; // Atualiza o estado de isLoading
        update();
      }
    } catch (e) {
      print('Failed to load products: $e');
      isLoading.value =
          false; // Atualiza o estado de isLoading mesmo em caso de erro
      update();
    }
  }

  void addProduct(product) async {
    try {
      var response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(product));

      if (response.statusCode == 200) {
        fetchProducts();
      } else {
        print('Failed to add product');
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteProduct(String name) async {
    try {
      var response = await http.delete(
        Uri.parse(
            '$apiUrl/mongo/item/'), // Endpoint correto para deletar um item
        body: {'nome': name}, // Passa o nome como parte do corpo da requisição
      );

      if (response.statusCode == 200) {
        fetchProducts();
      } else {
        print('Failed to delete product');
      }
    } catch (e) {
      print(e);
    }
  }
}
