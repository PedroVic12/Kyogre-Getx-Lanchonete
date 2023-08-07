import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:url_launcher/url_launcher.dart';

class CarrinhoController extends GetxController {
  late final CatalogoProdutosController produtosController;

  @override
  void onInit() {
    super.onInit();
  }

// Metodos do Pedido no whatsapp
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


  void abriWpp({required String phone, required String message}) async {
    var wpp_url = 'whatsapp://send?phone=${phone}&text=${message}';

    if (await canLaunchUrl(Uri.parse(wpp_url))){
      await launchUrl(Uri.parse(wpp_url));

    } else {
      throw 'Nao foi possivel enviar msg';
    }

  }






  String gerarResumoPedidoCardapio() {
    final items = _products.entries.map((entry) {
      final produto = entry.key;
      final quantidade = entry.value;
      return "${produto.nome} (x$quantidade)";
    }).join(', ');

    return "Resumo do pedido: $items. Total: R\$${total}.";
  }


  // Usando RxMap para tornar o mapa de produtos reativo
  var _products = <Produto, int>{}.obs;

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
