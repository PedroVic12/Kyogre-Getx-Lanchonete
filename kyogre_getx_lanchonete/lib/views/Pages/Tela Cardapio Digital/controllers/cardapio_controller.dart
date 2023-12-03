import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';

import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../Carrinho/CarrinhoController.dart';
import '../views/Menu Tab/menu_tab_bar_widget.dart';

class CardapioController extends GetxController {
  late String nomeCliente;
  late String telefoneCliente;
  late String idPedido;

  var isLoadingCardapio = true.obs;

  // Acessando os controladores
  final MenuProdutosController menuGradiente = Get.put(MenuProdutosController());
  final MenuProdutosRepository menuCategorias =      Get.put(MenuProdutosRepository());
  final RepositoryDataBaseController repositoryController =      Get.put(RepositoryDataBaseController());
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());

  final pikachu = PikachuController();

  @override
  void onReady() {
    super.onReady();
    update();
  }


  initPage() async {
    await Future.delayed(Duration(seconds: 5), () async {
     await setupCardapioDigitalWeb();
    });

    update();
  }


  bool mostrarBarraInferior = false;
  void toggleBarraInferior() {
      mostrarBarraInferior = !mostrarBarraInferior;
      update();
  }

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

  //setup
  Future setupCardapioDigitalWeb() async {
    isLoadingCardapio.value = true;

    try {
      await menuCategorias.getCategoriasRepository();
      await repositoryController.getProdutosDatabase();
      update();
    } catch (e) {
      print('---> Erro ao carregar dados: $e');
    }
    finally {
      if (repositoryController.dataBase_Array.isNotEmpty &&
          menuCategorias.MenuCategorias_Array.isNotEmpty
      ) {
        pikachu.cout('\nCategorias = ${menuCategorias.MenuCategorias_Array}');
        pikachu.cout('\nRepository = ${repositoryController.dataBase_Array}');

        // Só muda o estado para 'não carregando' se ambos os arrays estiverem carregados
        isLoadingCardapio.value = false;
        update();

        if (!isLoadingCardapio.value) {
          pikachu.loadDataSuccess('','Conteudos carregados? ${!isLoadingCardapio.value}');
          update();
          return isLoadingCardapio.value;
        }
      }
    }


  }

}
