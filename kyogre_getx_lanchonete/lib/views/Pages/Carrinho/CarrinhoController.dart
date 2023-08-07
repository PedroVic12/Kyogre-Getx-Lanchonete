import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  void enviarPedidoWhatsapp({required String phone, required String message}) async {
    String url() {
      if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}";
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

    Get.snackbar('Produto adicionado!',
        '${produto.nome} foi adicionado ao seu carrinho',
        snackPosition: SnackPosition.TOP,
        backgroundColor: CupertinoColors.activeGreen,
        backgroundGradient: LinearGradient(colors: [CupertinoColors.systemGreen, Colors.blue]),
        showProgressIndicator: true,
        duration: Duration(seconds: 2));
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
