// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/template/produtos_model.dart';
import '../../views/Pages/Tela Cardapio Digital/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../views/Pages/Tela Cardapio Digital/controllers/pikachu_controller.dart';

class RepositoryDataBaseController extends GetxController {
  final String sanduicheFile = 'lib/repository/models/sanduiches.json';
  final String hamburguersFile = 'lib/repository/models/hamburguer.json';
  final String pizzasFile = 'lib/repository/models/pizzas.json';

  final PikachuController pikachu = Get.put(PikachuController());
  final MenuProdutosRepository menuCategorias =
      Get.find<MenuProdutosRepository>();
  final RxList<ProdutoModel> dataBase_Array = <ProdutoModel>[].obs;
  bool isLoading = true;

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getJsonFilesRepositoryProdutos() async {
    final categorias = menuCategorias.MenuCategorias_Array;

    if (isLoading == true) {
      for (var i = 0; i < categorias.length; i++) {
        String produtoFile = 'lib/repository/cardapio/tabela_${i}.json';
        await carregandoDadosRepository(produtoFile);
      }
    }

    isLoading = false;
    update();
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

  List<ProdutoModel> filtrarEOrdenarPorNome(String categoriaDesejada) {
    // Filtra a lista com base na categoria desejada
    List<ProdutoModel> produtosFiltrados = dataBase_Array
        .where((produto) => produto.categoria == categoriaDesejada)
        .toList();

    // Ordena a lista filtrada por nome
    produtosFiltrados.sort((a, b) => a.nome.compareTo(b.nome));

    return produtosFiltrados;
  }

  List<ProdutoModel> filtrarCategoria(String categoriaDesejada) {
    return dataBase_Array
        .where((produto) => produto.categoria == categoriaDesejada)
        .toList();
  }

  void ordenarPorNome(List<ProdutoModel> produtos) {
    produtos.sort((a, b) => a.nome.compareTo(b.nome));
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
      print('\n\nErro ao Carregar Produtos JSON: $e');
      return [];
    }
  }
}
