
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';

class GroundonBackEndController extends GetxController {

  final carrinho = Get.find<CarrinhoPedidoController>();
  final pikachu = PikachuController();
  final CardapioController controller = Get.find<CardapioController>();

  // Converta as variáveis para
  String? nomeCliente;
  String? telefoneCliente;
  String? idPedido;

  @override
  void onReady() {
    super.onReady();
  }



  getDadosClienteGroundon(id)async {
    try {
      var response = await pikachu.API.get("https://rayquaza-citta-server.onrender.com/cliente/${id}");
      print('Status Code: ${response.statusCode}');
      return response;
    }
    catch (e) {
      pikachu.cout('Erro = ${e}');
    }
  }



  Future<Map<String, dynamic>> salvarDadosCarrinho(id_cliente) async {
    var dados = await getDadosClienteGroundon(id_cliente);
    pikachu.cout('DADOS GROUNDON = $dados');

    List<Map<String, dynamic>> itensPedido = [];

    // Adicionando os produtos ao pedido
    carrinho.SACOLA.entries.forEach((entry) {
      final produto = entry.key;
      final quantidade = entry.value;

      itensPedido.add({
        "quantidade": quantidade,
        "nome": produto.nome,
        "preco": produto.precos[0]['preco']
      });
    });

    // Estrutura do pedido alinhada ao modelo do servidor
    Map<String, dynamic> pedidoInfo = {
      "carrinho": itensPedido,
      "status": 'Em Processo',
      //"nome_cliente": dados['nome'],
      //"telefone_cliente": dados['telefone'],
      "total_pagar": carrinho.totalPrice,
    };

    return pedidoInfo;
  }


  enviarDadosPedidoGroundon(id) async {
    var dataPost = await salvarDadosCarrinho(id);
    pikachu.cout('Sacola Pedido =  $dataPost');

    try {
      var response = await pikachu.API.post(
        "https://rayquaza-citta-server.onrender.com/pedidos-kyogre/$id",
        data: jsonEncode(dataPost),
      );
      pikachu.loadDataSuccess('Dados Enviados', 'Pedido realizado com sucesso!');
    } catch (e) {
      print("Erro ao enviar pedido: $e");
    }
  }



  // Método para definir os detalhes do cliente
  void setClienteDetails(String nome, String telefone, String id) {
    nomeCliente = nome;
    telefoneCliente = telefone;
    idPedido = id;

    print('ID PEDIDO: $idPedido Cliente: $nomeCliente | Telefone: $telefoneCliente');
  }



  String gerarResumoPedidoCardapio() {
    final items = carrinho.SACOLA.entries.map((entry) {
      final produto = entry.key;
      final quantidade = entry.value;
      return "\n${quantidade}x ${produto.nome} (R\$ ${produto.precos[0]['preco']})";
    }).join('\n');

    // Calcula o tempo de entrega
    final agora = DateTime.now();
    final inicioEntrega = agora.add(Duration(minutes: 15));
    final fimEntrega = agora.add(Duration(minutes: 50));
    final formatoHora = DateFormat('HH:mm');


    // Acrescentando detalhes do cliente ao resumo
    final clienteDetails = controller.nomeCliente != null && controller.telefoneCliente != null
        ? "Cliente: $controller.nomeCliente\n\n Pedido #${controller.idPedido ?? 'N/A'}\n"
        : "";

    return """
  ▶ *RESUMO DO PEDIDO ${controller.idPedido}* 
   $clienteDetails
  *🛒 Itens do Pedido*:
   $items
   -------------------------------------
           ▶ TOTAL: R\$${carrinho.totalPrice}
   -------------------------------------
   🕙 Tempo de Entrega: aprox. ${formatoHora.format(inicioEntrega)} a ${formatoHora.format(fimEntrega)}
    """;
  }



Future<void> enviarPedidoWhatsapp({required String phone, required String message}) async {
    String generateUrl(String type) {
      switch (type) {
        case "wa.me":
          return "https://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
        case "api":
          return "https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(message)}";
        case "whatsapp":
        default:
          return 'whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}';
      }
    }

    // Determina quais URLs tentar, baseado no dispositivo do usuário
    List<String> urlsToTry = determineUrlsToTry();

    // Tenta abrir cada URL até que uma funcione
    for (var urlType in urlsToTry) {
      var url = generateUrl(urlType);
      if (await canLaunch(url)) {
        await launch(url, enableJavaScript: true, forceWebView: false);
        break; // Interrompe o loop se a URL for aberta com sucesso
      }
    }
  }

  List<String> determineUrlsToTry() {
    // Verifica o agente do usuário para determinar a plataforma
    if (html.window.navigator.userAgent.contains('Android')) {
      return ["whatsapp", "wa.me", "api"];
    } else if (html.window.navigator.userAgent.contains('iPhone') ||
        html.window.navigator.userAgent.contains('iPad')) {
      return ["wa.me", "api", "whatsapp"];
    } else if (html.window.navigator.userAgent.contains('Web')) {
      return ["wa.me", "api", "whatsapp"];
    } else {
      return ["wa.me", "whatsapp", "api"];
    }
  }
}