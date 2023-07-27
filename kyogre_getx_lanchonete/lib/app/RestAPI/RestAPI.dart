import 'dart:convert';
import 'package:delivery_kyogre_getx/Teoria%20do%20Caos/RestAPI/modelsApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RestApiPage extends StatefulWidget {
  const RestApiPage({Key? key}) : super(key: key);

  @override
  State<RestApiPage> createState() => _RestApiPageState();
}

class _RestApiPageState extends State<RestApiPage> {
  final _usersClientes = <DadosPedido>[].obs;
  final _isLoading = true.obs;
  final _errorMsg = ''.obs;

  @override
  void initState() {
    super.initState();
    getDataFromApi();
  }

  Future<void> getDataFromApi() async {
    Uri url = Uri.parse('http://localhost:5000/pedidos');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        _usersClientes.value =
            data.map((item) => DadosPedido.fromJson(item)).toList();
      } else {
        _errorMsg.value = '${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      _errorMsg.value = 'Falha na requisição: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> deleteDataFromApi(int id) async {
    Uri url = Uri.parse('http://localhost:5000/pedidos/$id');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        _errorMsg.value = 'Pedido removido com sucesso';
        getDataFromApi();
      } else {
        _errorMsg.value = 'Falha ao remover pedido';
      }
    } catch (e) {
      _errorMsg.value = 'Falha na requisição: $e';
    }
  }

  Future<void> updateDataFromApi(int id, DadosPedido pedido) async {
    Uri url = Uri.parse('http://localhost:5000/pedidos/$id');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pedido.toJson()),
      );
      if (response.statusCode == 200) {
        _errorMsg.value = 'Pedido atualizado com sucesso';
        getDataFromApi();
      } else {
        _errorMsg.value = 'Falha ao atualizar pedido';
      }
    } catch (e) {
      _errorMsg.value = 'Falha na requisição: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http API rest'),
      ),
      body: Obx(
            () {
          if (_isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_errorMsg.value.isNotEmpty) {
            return Center(
              child: Text(_errorMsg.value),
            );
          } else if (_usersClientes.isEmpty) {
            return const Text('Sem dados processados');
          } else {
            return ListView.builder(
              itemCount: _usersClientes.length,
              itemBuilder: (context, index) => getLinhaPedido(_usersClientes[index]),
            );
          }
        },
      ),
    );
  }

  Widget getLinhaPedido(DadosPedido pedido) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cliente: ${pedido.nome_cliente}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(pedido.itens_pedido),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                updateDataFromApi(pedido.id, pedido);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                deleteDataFromApi(pedido.id);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
