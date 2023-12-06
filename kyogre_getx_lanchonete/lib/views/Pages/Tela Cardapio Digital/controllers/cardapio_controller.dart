import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';

import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../Carrinho/CarrinhoController.dart';


class MenuProdutosController extends GetxController {
  var produtoIndex = 0.obs;
  var categoriasCarregadas = false.obs;
  final MenuProdutosRepository menuCategorias = Get.put(MenuProdutosRepository());

  //metodos
  void setProdutoIndex(int index) {
    produtoIndex.value = index;
    update(); // Notifica os ouvintes de que o estado foi atualizado
    print('Produto atualizado!');
  }

  void setCategoriasCarregadas(bool carregado) {

    if(menuCategorias.MenuCategorias_Array.isNotEmpty){
      categoriasCarregadas.value = carregado;
      update();
    }

  }

  @override
  void onInit() {
    super.onInit();
  }
}



class CardapioController extends GetxController {
  late String nomeCliente;
  late String telefoneCliente;
  late String idPedido;
  var isLoadingCardapio = true.obs;

  // Acessando os controladores]
  final MenuProdutosController menuGradiente = Get.put(MenuProdutosController());
  final MenuProdutosRepository menuCategorias =  Get.put(MenuProdutosRepository());
  final RepositoryDataBaseController repositoryController =  Get.put(RepositoryDataBaseController());
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());
  final pikachu = PikachuController();

  @override
  void onReady() {
    super.onReady();
    setupCardapioDigitalWeb();
    update();
  }
  bool mostrarBarraInferior = true;

  void toggleBarraInferior() {
    mostrarBarraInferior = !mostrarBarraInferior;
    update();
  }

  setIdPage(_id){
    idPedido = _id;
    update();
  }


  Future initPage() async {
    await Future.delayed(Duration(seconds: 5), () async {
      await setupCardapioDigitalWeb().then((_) async {
        // Verifica se os dados estão carregados
        if (repositoryController.dataBase_Array.isNotEmpty &&
            menuCategorias.MenuCategorias_Array.isNotEmpty) {
          // Espera por 2 segundos
          await Future.delayed(Duration(seconds: 2));
          // Atualiza o estado para refletir que os dados estão carregados
          menuGradiente.setCategoriasCarregadas(true);
          pikachu.cout('Produtos carregados!!!!');
        }
      });
    });
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
        update();
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
      await repositoryController.getProdutosDatabase();
      await menuCategorias.getCategoriasRepository();
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
          //pikachu.loadDataSuccess('','Conteudos carregados? ${!isLoadingCardapio.value}');
          return isLoadingCardapio.value;
        }
      }
    }


  }

}
