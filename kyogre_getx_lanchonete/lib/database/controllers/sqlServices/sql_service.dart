import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:get/get.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromJson(Map<String, dynamic> item) {
    return Product(
      name: item['NOME'],
      price: item['preco_1'].toDouble(),
      imageUrl: item['IMAGEM']
          .split(' | ')[0], // Alterado para pegar apenas a primeira imagem
    );
  }
}

class SQLiteService extends GetxController {
  bool isLoading = true;
  var products = <Map<dynamic, dynamic>>[].obs;
  final dio = Dio();

  String apiUrl = 'http://0.0.0.0:7070'; // Change this to your API URL

  fetchProducts() async {
    try {
      var response = await dio.get("$apiUrl/homeSQL");
      if (response.statusCode == 200) {
        print("\n\nDados SQL= ${response.data.toString()}");

        //var jsonData = json.decode(response.data) as List;
        //print(jsonData);

        products.addAll(response.data.cast<Map<dynamic, dynamic>>());
        update();
      }
    } catch (e) {
      print('Failed to load products: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void addProduct(Product product) async {
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
