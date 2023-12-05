
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

class backEndWhatsapp extends GetxController {

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







  Future<Map<String, dynamic>> salvarDadosCarrinho(id_cliente) async {

    var dados = getInfoPedidosGroundon(id_cliente);
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

    // Define o status inicial do pedido
    String statusInicial = 'Em Processo';

    // Estrutura do pedido alinhada ao modelo do servidor
    Map<String, dynamic> pedidoInfo = {
      "status": statusInicial,
      // "nome_cliente": controller.nomeCliente,  // Substitua pelo nome do cliente
      // "telefone_cliente": controller.telefoneCliente,  // Substitua pelo telefone do cliente
      "itens": itensPedido,
      "total": carrinho.totalPrice,
    };

    return pedidoInfo;
  }

  enviarDadosPedidoGroundon(id) async {
    var dataPost = await salvarDadosCarrinho(id);
    try {
      var response = await pikachu.API.post(
        "https://rayquaza-citta-server.onrender.com/pedidos-kyogre/$id",
        data: jsonEncode(dataPost),
      );
      pikachu.loadDataSuccess('Sucesso', 'Pedido enviado com sucesso!');
      print(response.data); // Para debug
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



   getInfoPedidosGroundon(id)async {
    try {
     var response = await pikachu.API.get("https://rayquaza-citta-server.onrender.com/cliente/${id}");
      print('Status Code: ${response.statusCode}');
     return response;
    }
    catch (e) {
      pikachu.cout('Erro = ${e}');
    }
  }

  //==============================! Pedido
  Future<Map<String, dynamic>> gerarPedidoInfo(id_cliente) async {

   var dados = getInfoPedidosGroundon(id_cliente);


    // Lista para armazenar os itens do pedido em formato JSON
    List<Map<String, dynamic>> pedidoJsonItems = [];

    // Itera sobre cada produto no carrinho e adiciona um objeto JSON à lista
    carrinho.SACOLA.entries.forEach((entry) {
      final produto = entry.key;
      final quantidade = entry.value;

      pedidoJsonItems.add({
        "quantidade": quantidade,
        "nome": produto.nome,
        "preco": produto.precos[0]['preco']
      });
    });

    var statusValues = ['Em Processo', 'Concluido','Cancelado' ];

    // Cria um objeto JSON completo para o pedido
    Map<String, dynamic> pedidoInfo = {
      "id": dados['id'],
      "nome": dados['nome'],
      "telefone": dados['telefone'],
      "status": statusValues[0],
      "endereco": "",
      // Adicione um campo para endereço na sua UI e substitua aqui
      "complemento": "",
      // Adicione um campo para complemento na sua UI e substitua aqui
      "formaPagamento": "",
      // Adicione um campo para forma de pagamento na sua UI e substitua aqui
      "pedido": pedidoJsonItems,
      "totalPagar": carrinho.totalPrice,
    };

    return pedidoInfo;
  }

  Future<void> enviarPedidoServidor(id_cliente) async {
    // Gera o objeto JSON do pedido usando o método acima
    Map<String, dynamic> pedidoInfo = await gerarPedidoInfo(id_cliente);

    // URL da API do servidor para enviar o pedido
    const String apiUrl = "https://rayquaza-citta-server.onrender.com/pedidos-kyogre";

    // Converte o pedidoInfo Map para uma String JSON
    String pedidoJson = jsonEncode(pedidoInfo);

    try {
      // Envia o pedido ao servidor como um corpo JSON
      var response = await pikachu.API.post(apiUrl,data: pedidoJson);

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
        throw '\n\nO servidor respondeu com o código de status: ${response
            .statusCode}';
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
    final clienteDetails = nomeCliente != null && telefoneCliente != null
        ? "Cliente: $nomeCliente\n\n Pedido #${idPedido ?? 'N/A'}\n"
        : "";

    return """
  ▶ *RESUMO DO PEDIDO ${idPedido}* 
   $clienteDetails
  *🛒 Itens do Pedido*:
   $items
   -------------------------------------
           ▶ TOTAL: R\$${carrinho.totalPrice}
   -------------------------------------
   🕙 Tempo de Entrega: aprox. ${formatoHora.format(inicioEntrega)} a ${formatoHora.format(fimEntrega)}
    """;
  }



// Metodos do Pedido no whatsapp
  Future<void> enviarPedidoWhatsapp({required String phone, required String message}) async {
    String generateUrl(String type) {
      switch (type) {
        case "wa.me":
          return "https://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
        case "api":
          return "https://api.whatsapp.com/send?phone=$phone&text=${Uri
              .encodeComponent(message)}";
        case "whatsapp":
        default:
          return 'whatsapp://send?phone=${phone}&text=${message}';
      }
    }

    Future<bool> canLaunchUrl(Uri uri) async {
      return await canLaunch(uri.toString());
    }

    Future<bool> launchUrl(Uri uri) async {
      return await launch(
          uri.toString(), enableJavaScript: true, forceWebView: true);
    }

    List<String> determineUrlsToTry() {
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


}