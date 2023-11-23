import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';


class PikachuController extends GetxController {
  // Para controle do estado de carregamento
  var pikachuInfo = {}.obs;
  var isLoading = true.obs;

  //Estrutura de Dados
  List <ProdutoModel> cartItens = [];
  int get qntd => cartItens.length;
  var preco = 0;
  double get totalPrice {
    return cartItens.fold(0, (previousValue, element) => previousValue++);
  }

  void adicionarCarrinho(ProdutoModel produto){
    cartItens.add(produto);
    preco++;
  }


  void cout(msg){
    print('\n\nDEBUG');
    print('==================================================================================');
    print(msg);
    print('==================================================================================\n');
  }


  void loadDataSuccess(String title, String message) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.cyan,
      snackPosition: SnackPosition.TOP,
    );
  }




  Future<void> loadingData() async {
    isLoading.value = true;
    try {
      // Simulando uma chamada de rede para buscar dados do Pikachu
      await Future.delayed(Duration(seconds: 2)); // Simulação de chamada de rede

      // Simulando dados recebidos
      pikachuInfo.value = {
        'nome': 'Pikachu',
        'tipo': 'Elétrico',

      };





    } catch (e) {
      // Trate erros aqui
      print('Erro ao carregar dados: $e');
    } finally {
      carregamentoConcluido();
      isLoading.value = false; // Conclui o carregamento
    }
  }

  void performActionWithPikachuData() {
    if (pikachuInfo.isNotEmpty) {
      print('Realizando ação com os dados de Pikachu: ${pikachuInfo.value}');
    } else {
      print('Dados do Pikachu não estão carregados.');
    }
  }

  @override
  void onReady() {
    super.onReady();
    loadingData(); // Carregar dados ao inicializar o controller
  }

  void carregamentoConcluido(){
    Get.snackbar('Rotinas Resetadas!', 'Tenha um otimo inicio de semana',
        showProgressIndicator: true,
        isDismissible: true,
        backgroundColor: Colors.cyan);
  }




}
