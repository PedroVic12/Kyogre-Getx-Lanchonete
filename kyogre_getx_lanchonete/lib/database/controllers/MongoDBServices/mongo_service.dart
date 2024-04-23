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
      preco2: item['preco_2'] != null ? item['preco_2'].toDouble() : 0.0,
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

  String apiUrl = 'http://0.0.0.0:7070'; // Change this to your API URL

  fetchProducts() async {
    try {
      isLoading(true);
      var response = await dio.get('$apiUrl/homeMongo');
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<Map<String, dynamic>> jsonData =
            responseData.cast<Map<String, dynamic>>();

        List<CardapioModel> cardapioList = jsonData.map((item) {
          List<String> imagens = (item['IMAGEM'] as String).split(' | ');
          return CardapioModel(
            id: item['_id'],
            nome: item['NOME'],
            categoria: item['CATEGORIA'],
            subCategoria: item['SUB_CAT'] ?? '',
            preco1: item['preco_1'].toDouble(),
            preco2: item['preco_2'] != null ? item['preco_2'].toDouble() : 0.0,
            ingredientes: item['IGREDIENTES'],
            imagens: imagens,
          );
        }).toList();

        products.addAll(
            cardapioList); // Adicione os objetos CardapioModel ao array products
        update();
      }
    } catch (e) {
      print('Failed to load products: $e');
    } finally {
      isLoading(false);
      print("results = ${products}");
      print("isLoading: ${isLoading.value}");

      update();
    }
  }

  void addProduct(product) async {
    try {
      var response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(product.toJson()));

      if (response.statusCode == 201) {
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
      var response = await http.delete(Uri.parse('$apiUrl/$name'));

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
