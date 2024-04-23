import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:get/get.dart';

class SQLiteService extends GetxController {
  var isLoading = true.obs;
  List<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;
  final dio = Dio();

  String apiUrl = 'http://0.0.0.0:7070'; // Altere isso para a URL da sua API

  fetchProducts() async {
    try {
      var response = await dio.get("$apiUrl/homeSQL");
      if (response.statusCode == 200) {
        print("\n\nDados SQL= ${response.data}");

        // Limpa a lista de produtos antes de adicionar os novos
        products.clear();

        // Adiciona cada produto individualmente à lista
        for (var item in response.data) {
          products.add(item);
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
      var response = await http.delete(
        Uri.parse(
            '$apiUrl/sqlite/item/'), // Endpoint correto para deletar um item
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

  void updateOrderStatus(String name, String newStatus) async {
    try {
      var response = await http.post(
        Uri.parse(
            '$apiUrl/sqlite/update_status'), // Endpoint para atualizar o status
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'nome': name, 'status': newStatus}),
      );

      if (response.statusCode == 200) {
        print('Order status updated successfully');
        // Você pode adicionar lógica adicional aqui, se necessário
      } else {
        print('Failed to update order status');
      }
    } catch (e) {
      print('Error updating order status: $e');
    }
  }
}
