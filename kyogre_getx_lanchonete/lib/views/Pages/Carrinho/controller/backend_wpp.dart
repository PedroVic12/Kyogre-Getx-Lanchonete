
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';

import '../../CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';

class backEndWhatsapp extends GetxController{

  final carrinho = CarrinhoPedidoController();
  final pikachu = PikachuController();

  // Converta as variáveis para
  String? nomeCliente;
  String? telefoneCliente;
  String? idPedido;

  @override
  void onReady() {
    super.onReady();
  }


  // Método para definir os detalhes do cliente
  void setClienteDetails(String nome, String telefone, String id) {
    nomeCliente = nome;
    telefoneCliente = telefone;
    idPedido = id;

    print('ID PEDIDO: $idPedido Cliente: $nomeCliente | Telefone: $telefoneCliente');
  }

  // Pedido
  Map<String, dynamic> gerarPedidoInfo() {
    // Lista para armazenar os itens do pedido em formato JSON
    List<Map<String, dynamic>> pedidoJsonItems = [];

    // Itera sobre cada produto no carrinho e adiciona um objeto JSON à lista
    carrinho.products.entries.forEach((entry) {
      final produto = entry.key;
      final quantidade = entry.value;

      pedidoJsonItems.add({
        "quantidade": quantidade,
        "nome": produto.nome,
        "preco": produto.precos
      });
    });

    // Cria um objeto JSON completo para o pedido
    Map<String, dynamic> pedidoInfo = {
      "nome": nomeCliente,
      "telefone": telefoneCliente,
      "endereco": "",  // Adicione um campo para endereço na sua UI e substitua aqui
      "complemento": "",  // Adicione um campo para complemento na sua UI e substitua aqui
      "formaPagamento": "",  // Adicione um campo para forma de pagamento na sua UI e substitua aqui
      "pedido": pedidoJsonItems,
      "totalPagar": carrinho.totalPrice,
    };

    return pedidoInfo;
  }

  Future<void> enviarPedidoServidor() async {
    // Gera o objeto JSON do pedido usando o método acima
    Map<String, dynamic> pedidoInfo = gerarPedidoInfo();

    // URL da API do servidor para enviar o pedido
    const String apiUrl = "https://suaapi.com/pedidos";

    // Converte o pedidoInfo Map para uma String JSON
    String pedidoJson = jsonEncode(pedidoInfo);

    try {
      // Envia o pedido ao servidor como um corpo JSON
      var response = await pikachu.API.post(
        pedidoJson,
      );

      // Verifica se o pedido foi enviado com sucesso (código de status HTTP 200)
      if (response.statusCode == 200) {
        Get.snackbar(
          'Pedido Enviado!',
          'Seu pedido foi enviado com sucesso para o servidor.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: CupertinoColors.systemGreen,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
      } else {
        // Se o servidor responder com um código de status diferente de 200,
        // lançar um erro
        throw 'O servidor respondeu com o código de status: ${response.statusCode}';
      }
    } catch (e) {
      // Algo deu errado ao enviar o pedido. Pode ser uma exceção de rede,
      // tempo de espera, etc.
      Get.snackbar(
        'Erro ao Enviar Pedido',
        'Ocorreu um erro ao enviar o pedido para o servidor: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: CupertinoColors.systemRed,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    }
  }

}

