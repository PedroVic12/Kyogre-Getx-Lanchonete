import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';

class CarrinhoController extends GetxController {
  // Usando RxMap para tornar o mapa de produtos reativo
  var _products = <ProductsModel, int>{}.obs;

  void adicionarProduto(ProductsModel produto) {
    if (_products.containsKey(produto)) {
      _products[produto] = (_products[produto] ?? 0) + 1;
    } else {
      _products[produto] = 1;
    }

    Get.snackbar('Produto adicionado!',
        'O produto ${produto.nome} foi adicionado ao carrinho',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 1));
  }

  void removerProduto(ProductsModel produto) {
    if (_products.containsKey(produto)) {
      if (_products[produto] == 1) {
        _products.remove(produto);
      } else {
        _products[produto] = (_products[produto] ?? 0) - 1;
      }
    }
  }

  get produtosCarrinho => _products;

  double get totalCarrinho {
    return _products.entries
        .map((product) => product.key.preco * product.value)
        .reduce((value, element) => value + element);
  }

  String get total {
    return _products.entries
        .map((product) => product.key.preco * product.value)
        .reduce((value, element) => value + element)
        .toStringAsFixed(2);
  }
}
