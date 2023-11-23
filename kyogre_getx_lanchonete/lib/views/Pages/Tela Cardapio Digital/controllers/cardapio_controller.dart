import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';

import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';

class CardapioController extends GetxController {
  late String nomeCliente;
  late String telefoneCliente;
  late String idPedido;


  var isLoading = false.obs;

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


  void setupCardapioDigital() async {
    final MenuProdutosController menuController =Get.find<MenuProdutosController>();
    final MenuProdutosRepository menuCategorias = Get.find<MenuProdutosRepository>();
    final RepositoryDataBaseController _repositoryController = Get.find<RepositoryDataBaseController>();
    final pikachu = PikachuController();

    var caregorias = menuCategorias.MenuCategorias_Array;
    var nome_produto_selecionado = menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome;

    //carregando
    await menuCategorias.getCategoriasRepository();
    await _repositoryController.loadData();
    update();

    pikachu.cout('Categorias = ${menuCategorias.MenuCategorias_Array}');
    pikachu.cout('Repository = ${_repositoryController.dataBase_Array}');

    //teste
    var products =  _repositoryController.filtrarCategoria('Pizzas');

    //debug
    pikachu.cout(products[0].categoria);


    caregorias.forEach((item) {
          print(item);
    });

  }



  Future<void> _carregandoDados() async {
    isLoading.value = true;
    try {
      // Simulando uma chamada de rede para buscar dados do Pikachu
      await Future.delayed(Duration(seconds: 3));

      // Simulando dados recebidos

    } catch (e) {
      print('Erro ao carregar dados: $e');
    } finally {
      isLoading.value = false;
    }
  }


}
