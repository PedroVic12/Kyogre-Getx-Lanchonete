import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:universal_io/io.dart';

class Produto {
  final String nome;
  final String descricao;
  final List<double> preco;
  final Uint8List imagem;
  final List<Map<String, dynamic>> adicionais;

  Produto({
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagem,
    required this.adicionais,
  });
}

class FirebaseApiService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://groundon-citta-cardapio-default-rtdb.firebaseio.com';

  FirebaseApiService() {
    _dio.options.headers['Access-Control-Allow-Origin'] = '*';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<void> uploadProduto(Produto produto) async {
    try {
      final Map<String, dynamic> produtoData = {
        "nome": produto.nome,
        "descricao": produto.descricao,
        "preco": produto.preco,
        "imagem": produto.imagem.toString(),
        "adicionais": produto.adicionais,
      };

      final response =
          await _dio.post('$_baseUrl/produtos.json', data: produtoData);

      if (response.statusCode == 200) {
        print("Produto cadastrado com sucesso!");
      } else {
        throw Exception('Erro ao cadastrar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar produto: $e');
    }
  }

  Future<List<Produto>> getProdutos() async {
    try {
      final response = await _dio.get('$_baseUrl/produtos.json');

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        if (data == null) return [];

        if (data is Map<String, dynamic>) {
          return data.entries.map((entry) {
            final produtoData = entry.value;
            return Produto(
              nome: produtoData['nome'],
              descricao: produtoData['descricao'],
              preco: List<double>.from(produtoData['preco']),
              imagem: Uint8List.fromList(List<int>.from(
                  produtoData['imagem'].split(',').map((e) => int.parse(e)))),
              adicionais:
                  List<Map<String, dynamic>>.from(produtoData['adicionais']),
            );
          }).toList();
        } else {
          throw Exception('Formato inesperado de dados');
        }
      } else {
        throw Exception('Erro ao buscar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }
}

class ProdutoController extends GetxController {
  final RxList<Produto> produtos = <Produto>[].obs;
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController adicionaisController = TextEditingController();

  final FirebaseApiService firebaseService = FirebaseApiService();

  Future<void> uploadProduto(Produto produto) async {
    try {
      await firebaseService.uploadProduto(produto);
    } catch (e) {
      print('Erro ao cadastrar produto: $e');
    }
  }

  Future<void> fetchProdutosFromFirebase() async {
    try {
      final fetchedProdutos = await firebaseService.getProdutos();
      produtos.assignAll(fetchedProdutos);
    } catch (e) {
      print('Erro ao buscar produtos: $e');
    }
  }

  Future<Uint8List> pickImageFromGallery() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*'
      ..click();

    await input.onChange.first;
    final html.File file = input.files!.first;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoad.first;

    final List<int> imageBytes = List<int>.from(
      reader.result as List<int>,
    );

    return Uint8List.fromList(imageBytes);
  }

  void clearProdutos() {
    produtos.clear();
  }
}

class ModalCadastroCardapio extends StatelessWidget {
  final controller = Get.put(ProdutoController());

  ModalCadastroCardapio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchProdutosFromFirebase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio Digital'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Cadastrar Produto'),
                    content: SizedBox(
                      width: 300,
                      height: 400,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: controller.nomeController,
                              decoration: const InputDecoration(
                                hintText: 'Nome do Produto',
                              ),
                            ),
                            TextField(
                              controller: controller.descricaoController,
                              decoration: const InputDecoration(
                                hintText: 'Descrição',
                              ),
                            ),
                            TextField(
                              controller: controller.precoController,
                              decoration: const InputDecoration(
                                hintText: 'Preço',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            TextField(
                              controller: controller.adicionaisController,
                              decoration: const InputDecoration(
                                hintText: 'Adicionais (JSON)',
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                final imagem =
                                    await controller.pickImageFromGallery();
                                final produto = Produto(
                                  nome: controller.nomeController.text,
                                  descricao:
                                      controller.descricaoController.text,
                                  preco: [
                                    double.parse(
                                        controller.precoController.text)
                                  ],
                                  imagem: imagem,
                                  adicionais: [
                                    {
                                      'adicional':
                                          controller.adicionaisController.text
                                    }
                                  ],
                                );
                                controller.uploadProduto(produto);
                                Get.back();
                              },
                              child: const Text(
                                  'Selecionar Imagem e Cadastrar Produto'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Cadastrar Produto'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.produtos.isEmpty) {
                return const Center(
                  child: Text('Nenhum produto cadastrado'),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.produtos.length,
                    itemBuilder: (context, index) {
                      final produto = controller.produtos[index];
                      return Column(
                        children: [
                          Image.memory(produto.imagem),
                          Text(produto.nome),
                          Text(produto.descricao),
                          Text('Preço: ${produto.preco.join(', ')}'),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
