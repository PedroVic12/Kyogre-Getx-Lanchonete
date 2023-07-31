import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';

class CarrinhoController extends GetxController {
  // Usando RxMap para tornar o mapa de produtos reativo
  var _products = <Produto, int>{}.obs;

  void adicionarProduto(Produto produto) {
    if (_products.containsKey(produto)) {
      _products[produto] = (_products[produto] ?? 0) + 1;
    } else {
      _products[produto] = 1;
    }

    Get.snackbar('Produto adicionado!',
        'O produto ${produto.nome} foi adicionado ao carrinho',
        snackPosition: SnackPosition.BOTTOM,
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

  get totalCarrinho {
    // Implemente o cálculo do total do carrinho aqui
    // Pode ser a soma dos preços dos produtos multiplicados pela quantidade
    return 0.0;
  }

  get total {
    // Implemente o cálculo do total aqui, similar ao totalCarrinho
    return 0.0;
  }
}