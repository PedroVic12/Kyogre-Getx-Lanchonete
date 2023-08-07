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
  Future<void> enviarPedidoWhatsapp({required String phone, required String message}) async {
    String url() {
      print('\nEnviando mensagem para: $phone');

      if (Theme.of(Get.context!).platform == TargetPlatform.linux ) {
        return "whatsapp://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
      }

      if (Theme.of(Get.context!).platform == TargetPlatform.android || Theme.of(Get.context!).platform == TargetPlatform.iOS) {
        return "https://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
      } else {
        return "https://send?phone=$phone&text=${Uri.encodeComponent(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      print('Nao foi possivel enviar o link');
      throw 'Could not launch $url';
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
        weight: FontWeight.bold,
        color: Colors.black, // ou qualquer outra cor padrão que você esteja usando
      ),
      messageText: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${produto.nome} ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'foi adicionado ao seu carrinho',
              style: TextStyle(color: Colors.white), // ou qualquer outra cor padrão que você esteja usando
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
