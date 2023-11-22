import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PikachuController extends GetxController {
  var pikachuInfo = {}.obs;
  var isLoading = true.obs; // Para controle do estado de carregamento

  // Método para carregar dados do Pikachu
  Future<void> carregandoDados() async {
    isLoading.value = true;
    try {
      // Simulando uma chamada de rede para buscar dados do Pikachu
      await Future.delayed(Duration(seconds: 2)); // Simulação de chamada de rede

      // Simulando dados recebidos
      pikachuInfo.value = {
        'nome': 'Pikachu',
        'tipo': 'Elétrico',
        // Outros dados relevantes
      };
    } catch (e) {
      // Trate erros aqui
      print('Erro ao carregar dados: $e');
    } finally {
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
    carregandoDados(); // Carregar dados ao inicializar o controller
  }

  void loadingData(){
    Get.snackbar('Rotinas Resetadas!', 'Tenha um otimo inicio de semana',
        showProgressIndicator: true,
        backgroundColor: Colors.redAccent.shade200);
  }

}
