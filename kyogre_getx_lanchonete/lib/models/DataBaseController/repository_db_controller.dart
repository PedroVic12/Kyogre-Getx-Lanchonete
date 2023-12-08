// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';
import '../../views/Pages/Tela Cardapio Digital/controllers/pikachu_controller.dart';

class RepositoryDataBaseController extends GetxController {
  final String sanduicheFile = 'lib/repository/models/sanduiches.json';
  final String hamburguersFile = 'lib/repository/models/hamburguer.json';
  final String pizzasFile = 'lib/repository/models/pizzas.json';

  final PikachuController pikachu = Get.put(PikachuController());

  final RxList<ProdutoModel> dataBase_Array = <ProdutoModel>[].obs;
  bool isLoading = true; // <---- Change this to false after loading data

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> setupJsonFilesProdutos() async {
    var primeiro = 15;
    var ultimo = 24;
    if (isLoading == true) {
      for (var i = primeiro; i < ultimo; i++) {
        final String produtoFile = 'lib/repository/cardapio_json/tabela$i.json';
        print(produtoFile);

        //final modelProduto = jsonToModel(produtoFile.nome, produtoFile.PRECO);
        //carregandoDadosRepository(modelProduto);
      }
    }

    isLoading = false;
    update();
  }

  jsonToModel(nome, preco) {
    return {
      "nome": nome,
      "categoria": "",
      "precos": [
        {"preco_1": preco, "descricao": "P"},
        {"preco_2": 0.0, "descricao": "M"}
      ],
      "ingredientes": ["", ""],
      "imagem": "img.jpg"
    };
  }

  Future getProdutosDatabase() async {
    if (isLoading == true) {
      //await fetchAllProducts();
      await carregandoDadosRepository(pizzasFile);
      await carregandoDadosRepository(hamburguersFile);
      await carregandoDadosRepository(sanduicheFile);
      isLoading = false;
      update();
    }
  }

  Future<void> carregandoDadosRepository(String file) async {
    isLoading = true;

    try {
      final String response = await rootBundle.loadString(file);
      final List<dynamic> dados = json.decode(response);
      List<ProdutoModel> produtos =
          dados.map((item) => ProdutoModel.fromJson(item)).toList();

      dataBase_Array.addAll(produtos);
    } catch (e) {
      pikachu.cout('ERRO ao carregar dados: $e');
    } finally {
      isLoading = false;
    }
  }

  List<ProdutoModel> filtrarCategoria(String categoriaDesejada) {
    return dataBase_Array
        .where((produto) => produto.categoria == categoriaDesejada)
        .toList();
  }

  // Metodos JSON
  Future<List<ProdutoModel>> lerArquivoJson(String filePath) async {
    try {
      final String response = await rootBundle.loadString(filePath);
      final List<dynamic> jsonData = await json.decode(response);

      // Convertendo o JSON para uma lista de objetos ProdutoModel
      var _produto =
          jsonData.map((jsonItem) => ProdutoModel.fromJson(jsonItem)).toList();
      return _produto;
    } catch (e) {
      print('\n\nErro ao carregar Produtos JSON do DataBase: $e');
      return [];
    }
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
