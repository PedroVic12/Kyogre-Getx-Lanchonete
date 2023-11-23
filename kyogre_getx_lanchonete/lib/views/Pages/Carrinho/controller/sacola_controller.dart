import 'package:get/get.dart';

import '../../../../models/DataBaseController/template/produtos_model.dart';

class CarrinhoPedidoController extends GetxController{
  // Para controle do estado de carregamento
  var pikachuInfo = {}.obs;
  var isLoading = true.obs;


  //Estrutura de Dados
  List <ProdutoModel> cartItens = [];

  // Usando RxMap para tornar o mapa de produtos reativo
  final products = <ProdutoModel, int>{}.obs;

  int get qntd => cartItens.length;
  var preco = 0;
  double get totalPrice {
    return cartItens.fold(0, (previousValue, element) => previousValue++);
  }


  void removerProduto(ProdutoModel produto) {
    if (products.containsKey(produto)) {
      if (products[produto] == 1) {
        products.remove(produto);
      } else {
        products[produto] = (products[produto] ?? 0) - 1;
      }
    }
  }


  void adicionarCarrinho(ProdutoModel produto){
    cartItens.add(produto);
    preco++;
  }


}

