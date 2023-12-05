import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

import '../../../../app/widgets/Custom/CustomText.dart';


class PikachuController extends GetxController {
  // Para controle do estado de carregamento
  var pikachuInfo = {}.obs;
  var isLoading = true.obs;
  final Dio API = Dio();



  void snackBarCarrinho(produto){
    Get.snackbar(
      'Produto adicionado!',
      '', // Deixamos a mensagem vazia porque usaremos messageText para a formatação
      titleText: const CustomText(
        text: 'Produto adicionado!',
        size: 18,
        weight: FontWeight.bold,
        color: Colors.black, // ou qualquer outra cor padrão que você esteja usando
      ),
      messageText: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${produto.nome} ',
              style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextSpan(
              text: 'foi adicionado ao seu carrinho',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18), // ou qualquer outra cor padrão que você esteja usando
            ),
          ],
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: CupertinoColors.activeGreen,
      backgroundGradient: LinearGradient(colors: [CupertinoColors.systemGreen, Colors.blue]),
      showProgressIndicator: true,
      duration: const Duration(seconds: 1),
    );
  }



  void cout(msg){
    print('\n\nDEBUG');
    print('============================================================================');
    print(msg);
    print('============================================================================\n');
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
