import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
class CatalogoProdutosController extends GetxController {
  String categoria = 'Todos os Produtos';
  final DataBaseController _dataBaseController = Get.find<DataBaseController>();
  Produto? selectedProduct;
  RxList<Produto> allProdutos = RxList<Produto>();  // Mudamos o nome para 'allProdutos'
  RxList<Produto> produtos = RxList<Produto>();  // Esta lista vai conter os produtos filtrados

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
    allProdutos.addAll(await _dataBaseController.getAllProducts());
    _atualizarProdutosFiltrados();
    selectedProduct = produtos.isNotEmpty ? produtos[0] : null;
    print('Produto selecionado: ${selectedProduct?.nome}');
    update();
  }

  void _atualizarProdutosFiltrados() {
    if (categoria == 'Todos os Produtos') {
      produtos.assignAll(allProdutos);
    } else {
      produtos.assignAll(allProdutos.where((produto) => produto.tipo_produto == categoria));
    }
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
    _atualizarProdutosFiltrados();
  }
}

