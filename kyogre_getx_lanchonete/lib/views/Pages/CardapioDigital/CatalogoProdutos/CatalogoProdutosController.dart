import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';

class CatalogoProdutosController extends GetxController {
  String?
      categoria; // Mudado para nullable já que não temos mais 'Todos os Produtos'
  final DataBaseController _dataBaseController = Get.put(DataBaseController());
  final MenuProdutosRepository repository = Get.put(MenuProdutosRepository());

  Produto? selectedProduct;
  RxList<Produto> allProdutos = RxList<Produto>();
  RxList<Produto> produtos = RxList<Produto>();


  void getCategorias(){
    repository.fetchCategorias();
  }


  final List<String> catalogoCategorias = [
    'Sanduíches',
    'Petiscos',
    'Açaí e Pitaya',
  ];

  @override
  void onInit() {
    super.onInit();
    _carregarProdutos();
  }

  // MUDANDO DE PRODUTOS
  var selectedCategoryIndex = 0.obs;

  void setCategoria(int index) {
    if (index >= 0 && index < catalogoCategorias.length) {
      selectedCategoryIndex.value = index;
      categoria = catalogoCategorias[index];
      _atualizarProdutosFiltrados();
    }
  }

  void setCategory(int index) {
    selectedCategoryIndex.value = index;
    categoria = catalogoCategorias[index];
    _atualizarProdutosFiltrados();
  }

  // carregando os produtos
  Future<void> _carregarProdutos() async {
    print('Carregando produtos...');
    allProdutos.addAll(await _dataBaseController.getAllProducts());
    _atualizarProdutosFiltrados();
    selectedProduct = produtos.isNotEmpty ? produtos[0] : null;
    print('Produto selecionado: ${selectedProduct?.nome}');
  }

  void _atualizarProdutosFiltrados() {
    if (categoria != null) {
      produtos.assignAll(
          allProdutos.where((produto) => produto.tipo_produto == categoria));
    } else {
      produtos.assignAll(
          []); // Se a categoria for nula, a lista de produtos será vazia
    }
  }

  void selectProduct(int index) {
    if (index >= 0 && index < produtos.length) {
      selectedProduct = produtos[index];
      print('Produto selecionado: ${selectedProduct?.nome}');
    }
  }

// Método setCategoria já não é mais necessário, pois o setCategory agora faz o trabalho
}
