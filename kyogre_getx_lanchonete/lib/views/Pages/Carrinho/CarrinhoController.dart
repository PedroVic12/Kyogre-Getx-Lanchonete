import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart'; // Usado para formatar a hora

class CarrinhoController extends GetxController {
  late final CatalogoProdutosController produtosController;
  // Converta as variáveis para
  String? nomeCliente;
  String? telefoneCliente;
  String? idPedido;

  @override
  void onInit() {
    super.onInit();
  }


  // Usando RxMap para tornar o mapa de produtos reativo
  final _products = <Produto, int>{}.obs;

  // Método para definir os detalhes do cliente
  void setClienteDetails(String nome, String telefone, String id) {
    nomeCliente = nome;
    telefoneCliente = telefone;
    idPedido = id;

    print('ID PEDIDO: $idPedido Cliente: $nomeCliente | Telefone: $telefoneCliente');
  }

  String gerarResumoPedidoCardapio() {
    final items = _products.entries.map((entry) {
      final produto = entry.key;
      final quantidade = entry.value;
      return "\n${quantidade}x ${produto.nome} (R\$ ${produto.preco?.preco1})";
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
  ▶ *RESUMO DO PEDIDO* 
   $clienteDetails
  *🛒 Itens do Pedido*:
   $items
   -------------------------------------
           ▶ TOTAL: R\$${total}
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
          return "https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(message)}";
        case "whatsapp":
        default:
          return 'whatsapp://send?phone=${phone}&text=${message}';
      }
    }

    Future<bool> canLaunchUrl(Uri uri) async {
      return await canLaunch(uri.toString());
    }

    Future<bool> launchUrl(Uri uri) async {
      return await launch(uri.toString(), enableJavaScript: true, forceWebView: true);
    }

    List<String> determineUrlsToTry() {
      if (html.window.navigator.userAgent.contains('Android')) {
        return ["whatsapp", "wa.me", "api"];
      } else if (html.window.navigator.userAgent.contains('iPhone') || html.window.navigator.userAgent.contains('iPad')) {
        return ["wa.me", "api", "whatsapp"];
      } else if (html.window.navigator.userAgent.contains('Web')) {
        return ["wa.me", "api", "whatsapp"];
      } else {
        return ["wa.me", "whatsapp", "api"];
      }
    }

    Future<void> tryLaunchRecursive(List<String> urls) async {
      if (urls.isEmpty) {
        print('Nenhum URL funcionou. Lançando exceção.');
        throw 'Nenhum URL funcionou';
      }

      var urlString = generateUrl(urls.first);
      print('Tentando abrir o URL: $urlString');

      if (await canLaunchUrl(Uri.parse(urlString))) {
        try {
          await launchUrl(Uri.parse(urlString));
          print('URL $urlString aberto com sucesso!');

          Get.rawSnackbar(
              message: 'WhatsApp Aberto com Sucesso!',
              title: 'URL usado: $urlString\nPlataforma: ${Platform.operatingSystem}',
              backgroundColor: CupertinoColors.systemGreen,
              duration: Duration(seconds: 1)
          );
          return;

        } catch (e) {
          print('Falha ao tentar abrir: $urlString');
          Get.snackbar(
              'Error: ${e}',
              'URL usado: $urlString\nPlataforma: ${Platform.operatingSystem}',
              snackPosition: SnackPosition.TOP,
              backgroundColor: CupertinoColors.systemRed,
              colorText: Colors.white,
              duration: Duration(seconds: 5)
          );
        }
      }

      // Se a URL atual falhar, tente a próxima na lista
      await tryLaunchRecursive(urls.sublist(1));
    }

    List<String> urlsToTry = determineUrlsToTry();
    await tryLaunchRecursive(urlsToTry);
  }


  Future<void> sendPedidoWpp({required String phone, required String message}) async {
    String generateUrl(String type) {
      switch (type) {

        case "wa.me":
          return "https://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
        case "api":
          return "https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(message)}";
        case "whatsapp":
          return 'whatsapp://send?phone=${phone}&text=${message}';
        default:
          return 'whatsapp://send?phone=${phone}&text=${message}';
      }
    }

    Future<bool> canLaunchUrl(Uri uri) async {
      return await canLaunch(uri.toString());
    }

    Future<bool> launchUrl(Uri uri) async {
      return await launch(uri.toString(), enableJavaScript: true, forceWebView: true);
    }

    List<String> urlsToTry;

    if (html.window.navigator.userAgent.contains('Android')) {
      urlsToTry = ["whatsapp", "wa.me", "api"];
      print('Detectado plataforma Android. Tentando URLs na ordem: $urlsToTry');
    } else if (html.window.navigator.userAgent.contains('iPhone') || html.window.navigator.userAgent.contains('iPad')) {
      urlsToTry = ["wa.me", "api", "whatsapp"];
      print('Detectado plataforma iOS. Tentando URLs na ordem: $urlsToTry');
    } else if (html.window.navigator.userAgent.contains('Web')) { // Detectando web
      urlsToTry = ["wa.me", "api", "whatsapp"];
      print('Detectado Flutter Web. Tentando URLs na ordem: $urlsToTry');
    } else {
      urlsToTry = [ "wa.me", "whatsapp", "api"];
      print('Detectado plataforma desconhecida. Tentando URLs na ordem: $urlsToTry');
    }



    for (var urlType in urlsToTry) {
      var urlString = generateUrl(urlType);
      print('Tentando abrir o URL: $urlString');

      if (await canLaunchUrl(Uri.parse(urlString))) {

        try{
          await launchUrl(Uri.parse(urlString));
          print('URL $urlString aberto com sucesso!');

          // Mostrar snackbar com detalhes do link e plataforma
          Get.rawSnackbar(
              message: 'WhatsApp Aberto com Sucesso!',
              title: 'URL usado: $urlString\nPlataforma: ${Platform.operatingSystem}',
              backgroundColor: CupertinoColors.systemGreen,
              duration: Duration(seconds: 1)
          );


          return; // Se lançado com sucesso, saia da função
        } catch (e){
          print('Falha ao tentar abrir: $urlString em ${Platform.operatingSystem}');
          Get.snackbar(
              'Error: ${e}',
              'URL usado: $urlString\nPlataforma: ${Platform.operatingSystem}',
              snackPosition: SnackPosition.TOP,
              backgroundColor: CupertinoColors.systemRed,
              colorText: Colors.white,
              duration: Duration(seconds: 5)
          );
        }

      }
    }

    print('Nenhum URL funcionou para a plataforma ${Platform.operatingSystem}. Lançando exceção.');
    throw 'Nenhum URL funcionou para a plataforma ${Platform.operatingSystem}';
  }




  // Metodos de controle do carrinho
  void adicionarProduto(Produto produto) {
    if (_products.containsKey(produto)) {
      _products[produto] = (_products[produto] ?? 0) + 1;
    } else {
      _products[produto] = 1;
    }

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

  void removerProduto(Produto produto) {
    if (_products.containsKey(produto)) {
      if (_products[produto] == 1) {
        _products.remove(produto);
      } else {
        _products[produto] = (_products[produto] ?? 0) - 1;
      }
    }
  }

  get produtosCarrinho => _products;


  String get total {
    return _products.entries
        .map((product) => (product.key.preco?.preco1 ?? 0) * product.value)
        .reduce((value, element) => value + element)
        .toStringAsFixed(2);
  }

}
