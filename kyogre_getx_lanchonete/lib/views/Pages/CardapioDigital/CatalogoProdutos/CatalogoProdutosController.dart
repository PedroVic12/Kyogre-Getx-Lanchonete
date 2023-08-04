import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';

class CatalogoProdutosController extends GetxController {
  String categoria = 'Todos os Produtos';
  final DataBaseController _dataBaseController = Get.find<DataBaseController>();
  Produto? selectedProduct;
  List<Produto> produtos = [];

  final List<String> categorias = [
    'Todos os Produtos',
    'Sanduíches Tradicionais',
    'Açaí e Pitaya',
    'Petiscos',
  ];

  @override
  void onInit() {
    super.onInit();
    _carregarProdutosFiltrados();
  }

  Future<void> _carregarProdutosFiltrados() async {
    print('Carregando produtos filtrados...');
    produtos = await _dataBaseController.getAllProducts();
    if (categoria != 'Todos os Produtos') {
      produtos = produtos.where((produto) => produto.tipo_produto == categoria).toList();
    }
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
    print('Setando a categoria: $novaCategoria');
    categoria = novaCategoria;
    _carregarProdutosFiltrados();
  }
}
