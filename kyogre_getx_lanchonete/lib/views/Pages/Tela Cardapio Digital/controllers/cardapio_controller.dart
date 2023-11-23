import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';

import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../models/DataBaseController/template/produtos_model.dart';
import '../../CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../Carrinho/CarrinhoController.dart';

class CardapioController extends GetxController {
  late String nomeCliente;
  late String telefoneCliente;
  late String idPedido;


  var isLoading = false.obs;



  // Acessando os controladores
  final RepositoryDataBaseController repositoryController = Get.find<RepositoryDataBaseController>();
  final CarrinhoController carrinhoController = Get.find<CarrinhoController>();
  final MenuProdutosRepository menuCategorias = Get.find<MenuProdutosRepository>();
  final MenuProdutosController menuController =Get.find<MenuProdutosController>();
  final pikachu = PikachuController();



 // metodos backend
  Future<void> fetchClienteNome(String clienteId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://rayquaza-citta-server.onrender.com/cliente/$clienteId'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        nomeCliente = data['nome'];
        telefoneCliente = data['telefone'];
        idPedido = data['id'];
        update(); // Atualiza os ouvintes, se houver
      } else {
        print('Failed to fetch the client name.');
      }
    } catch (e) {
      print('Erro ao buscar nome do cliente: $e');
    }
  }

  Future<String> fetchIdPedido() async {
    final response_id = await http.get(
        Uri.parse('https://rayquaza-citta-server.onrender.com/receber-link'));

    if (response_id.statusCode == 200) {
      String id_data = response_id.body;
      return id_data;
    } else {
      throw Exception('Failed to fetch ID');
    }
  }


  // metodos JSON
  Future readingDataJson(url) async {
    Dio api = Dio();

    var response = await api.get(url);
    var _produtos = response.data;
    return _produtos;
  }
  Future readJson(file) async {
    final String response = await rootBundle.loadString(file);
    final data = await json.decode(response);
    return data;
  }
  Future<List>  lerArquivoJson(String filePath) async {
    try {

      var data = await readingDataJson('https://api.npoint.io/796847de75f3705645c2');
      pikachu.cout('JSON = ${data}');

      return data;

    } catch (e) {
      pikachu.cout('ERRO JSON = \n $e');
      return [];
    }
  }



  //setup
  Future<void> fetchAllProdutos() async {
    await carregandoDadosRepository(repositoryController.pizzasFile);
    await carregandoDadosRepository(repositoryController.sanduicheFile);
    //await carregandoDadosRepository(repositoryController.hamburguersFile);


  }

  Future setupCardapioDigitalWeb() async{

    await menuCategorias.getCategoriasRepository();
    //await repositoryController.loadData();
    await fetchAllProdutos();

    pikachu.cout('Categorias = ${menuCategorias.MenuCategorias_Array}');
    //pikachu.cout('Repository = ${repositoryController.dataBase_Array}');
    pikachu.cout('MY array = ${repositoryController.my_array}');

    if(isLoading.value = false){
      print('\n\n\nDatabase Carregado!');
    }

    update();
  }

  Future carregandoDadosRepository(file) async {
    isLoading.value = true;

    // Limpa o array existente
    repositoryController.my_array.clear();

    try {
      // Simulando uma chamada de rede para buscar dados do Pikachu
      await Future.delayed(Duration(seconds: 2));

      // Le dados json file
      var dados = await readJson(file);
      pikachu.cout(dados);
      List produtos = dados.map((item) => ProdutoModel.fromJson(item)).toList();


      for (var index = 0; index < produtos.length; index++){
        pikachu.cout('${index} = ${produtos[index].nome} | ${produtos[index].categoria}' );
        repositoryController.my_array.add(produtos[index]);
      }

    } catch (e) {
      pikachu.cout('ERRO ao carregar dados: $e');
    } finally {
      isLoading.value = false;
    }
    return  repositoryController.my_array;

  }



}
