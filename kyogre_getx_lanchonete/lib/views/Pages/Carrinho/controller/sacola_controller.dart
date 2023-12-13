import 'package:get/get.dart';

import '../../../../models/DataBaseController/template/produtos_model.dart';

class CarrinhoPedidoController extends GetxController{
  // Para controle do estado de carregamento
  var isLoading = true.obs;

  // Usando RxMap para tornar o mapa de produtos reativo
  final SACOLA = <ProdutoModel, int>{}.obs;
  var preco = 0;


  double get totalPrice {
    return SACOLA.entries
        .map((product) => (product.key.preco_1 ?? 0.0) * product.value)
        .fold(0.0, (previousValue, element) => previousValue + element);
  }


  void removerProduto(ProdutoModel produto) {
    if (SACOLA.containsKey(produto)) {
      if (SACOLA[produto] == 1) {
        SACOLA.remove(produto);
      } else {
        SACOLA[produto] = (SACOLA[produto] ?? 0) - 1;
      }
    }
  }


  void adicionarCarrinho(ProdutoModel produto) {
    if (SACOLA.containsKey(produto)) {
      SACOLA[produto] = (SACOLA[produto] ?? 0) + 1;
    } else {
      SACOLA[produto] = 1;
    }

    // Atualize o preço total
    updateTotalPrice();
  }

  double updateTotalPrice() {
    var price = SACOLA.entries
        .map((product) => (product.key.preco_1 ?? 0.0) * product.value)
        .fold(0.0, (previousValue, element) => previousValue + element);

    return price;
  }


}

