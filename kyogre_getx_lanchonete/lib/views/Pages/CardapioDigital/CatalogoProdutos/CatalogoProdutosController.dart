import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';

class CatalogoProdutosController extends GetxController {
  String categoria = 'Todos os Produtos';
  final DataBaseController _dataBaseController = Get.find<DataBaseController>();
  Produto? selectedProduct;
  RxList<Produto> produtos = RxList<Produto>();

  final List<String> categorias = [
    'Todos os Produtos',
    'Sanduíches Tradicionais',
    'Açaí e Pitaya',
    'Petiscos',
  ];

  @override
  void onInit() {
    super.onInit();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    print('Carregando produtos...');
    produtos = RxList<Produto>(await _dataBaseController.getAllProducts());
    selectedProduct = produtos.isNotEmpty ? produtos[0] : null;
    print('Produto selecionado: ${selectedProduct?.nome}');
    update();
  }

  void selectProduct(int index) {
    if (index >= 0 && index < produtos.length) {
      selectedProduct = produtos[index];
      print('Produto selecionado: ${selectedProduct?.nome}');
      update();
    }
  }

  void setCategoria(String novaCategoria) {
    categoria = novaCategoria;
    update();
  }

  List<Produto> get produtosFiltrados {
    if (categoria == 'Todos os Produtos') {
      return produtos;
    } else {
      return produtos.where((produto) => produto.tipo_produto == categoria).toList();
    }
  }
}
