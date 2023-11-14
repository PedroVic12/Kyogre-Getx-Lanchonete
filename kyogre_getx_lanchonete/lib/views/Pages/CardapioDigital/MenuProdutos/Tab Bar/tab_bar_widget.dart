import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/Tab%20Bar/widgets.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import '../../../../../models/DataBaseController/DataBaseController.dart';
import '../../../../../models/DataBaseController/template/produtos_model.dart';
import '../Cards/glass_card_widget.dart';
import '../repository/MenuRepository.dart';
import '../repository/produtos_model.dart';
import 'models_tabBar.dart';
import 'views/folear_cardapio_produtos.dart';
import '../produtos_controller.dart';

class TabBarWidget extends StatefulWidget {
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with TickerProviderStateMixin {
  late TabController _tabController;
  var myTabs_array = <Tab>[].obs;
  final MenuProdutosController menuController = Get.find<MenuProdutosController>();
  final CatalogoProdutosController catalogoController = Get.find<CatalogoProdutosController>();



  getCategorias() async {
    final categoriasProdutos = await menuController.fetchCategorias();
    return categoriasProdutos;
  }

  void cout(msg){
    print('\n\n======================================================');
    print(msg);
    print('======================================================');

  }

  Future<void> loadTabs() async {
    // Obtenha as categorias de produtos
    var categoriasProdutos = await menuController.fetchCategorias();


    cout('Produtos = ${categoriasProdutos.length}');
    cout(categoriasProdutos);

    // Limpa a lista de abas para evitar duplicatas
    myTabs_array.clear();

    // Cria as abas baseadas nas categorias de produtos
    myTabs_array.addAll(categoriasProdutos.map((categoria) => Tab(text: categoria.nome)).toList());

    // Inclui outras abas que são fixas
    myTabs_array.addAll([
      Tab(text: 'Status'),
      Tab(text: 'Calls'),
    ]);


    // Inicializa o TabController com o número correto de abas
    _tabController = TabController(vsync: this, length: myTabs_array.length);



    print(myTabs_array);

    // Exibe uma Snackbar com o número de produtos
    Get.snackbar(
      'Produtos Carregados', // Título da Snackbar
      'Array = ${myTabs_array.length}',
      snackPosition: SnackPosition.BOTTOM, // Posição da Snackbar na tela
    );

  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        TabBarScrollCardapioCategorias(),
        TabBarViewCardapioProdutosDetails(),

        SizedBox(
          height: 200,
          child: FolearCardapioDigital(),
        )
      ],
    );
  }

  Widget TabBarScrollCardapioCategorias() {
    final menuController = Get.find<MenuProdutosController>();
    final MenuProdutosRepository repository = Get.put(MenuProdutosRepository());

    var categoriasProdutos = repository.fetchCategorias();
    cout('Categorias = ${categoriasProdutos[0].nome}');


    return Container(
      margin: const EdgeInsets.all(6),
      height: 130,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CupertinoColors.activeOrange, CupertinoColors.systemYellow.darkHighContrastElevatedColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.7, 1),
            blurRadius: 50,
            spreadRadius: 3,
            color: Colors.yellow,
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        labelPadding: const EdgeInsets.all(16),
        isScrollable: true,
        unselectedLabelColor: Colors.black,
        indicator: CircleTabIndicator(color: Colors.purpleAccent.shade700, radius: 64),
        tabs: [
          for (var index = 0; index < categoriasProdutos.length; index++)
         _buildTabBarMenuGradiente(categoriasProdutos[index].nome, categoriasProdutos[index].iconPath,index)

        ],
      ),
    );
  }


  Widget _buildTabBarMenuGradiente(String nome, Icon iconPath, int index) {
    final menuController = Get.find<MenuProdutosController>();

    return Obx(() {
      bool isSelected = menuController.produtoIndex.value == index;

      return GestureDetector(
        onTap: () {
          menuController.setProdutoIndex(index);
        },
        child: Container(
          width: 120,
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0.5, 1),
                blurRadius: 3,
                spreadRadius: 2,
                color: Colors.yellow.shade300,
              ),
            ],
            gradient: isSelected
                ? LinearGradient(colors: [Colors.greenAccent, Colors.green])
                : LinearGradient(colors: [Colors.deepPurple.shade100, CupertinoColors.activeBlue.highContrastElevatedColor]),
          ),
          child: Center(
            child: CustomTab(
              text: nome,
              iconPath: iconPath,
              isSelected: isSelected,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon:  IconePersonalizado(tipo: Icons.menu),
          ),
          const SizedBox(width: 16),
          const CustomText(
            text: 'Categorias de Lanches',
            size: 24,
            weight: FontWeight.bold,
          ),

        ],
      ),
    );
  }





  // TODO CARDS PRODUTOS
  Widget TabBarViewCardapioProdutosDetails() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(6),
        width: double.maxFinite,
        height: 200,
        color: Colors.white70,
        child: TabBarView(
          controller: _tabController,
          children: [
            Center(child: Text('hello'),),
            _listViewProdutos(),
            Center(child: Text('Skywalker')),
            _cardProdutos(),
            GlassCardWidget(),
            //_buildMenuCategorias()

          ],
        ),
      ),
    );
  }

  Widget _listViewProdutos(){
    return ListView.builder(

        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_,index){
      return Center(
        child: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.brown

            //image: DecorationImage(image: "plano de fundo de mesa de bar madeirada", fit: Boxfit)
          ),
          child: Text('Index = ${index}'),
        ),
      );
    });
  }

  Widget _cardProdutos()  {

    final CatalogoProdutosController catalogoController = Get.find<CatalogoProdutosController>();
    final List<Produto> produtos = catalogoController.produtos;




    final nomes_categorias = catalogoController.catalogoCategorias;
    var produtos_carregados = catalogoController.getCategorias();
    final MenuProdutosController menuController = Get.find<MenuProdutosController>();
    var categoriasProdutos =  getCategorias();


    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (_, index) {
        final Produto produto = produtos[index];

        return Card(
          color: Colors.blueGrey.shade700,
          child: ListTile(
            title: Text('nome = ${nomes_categorias[0].toString()}'),
            trailing: CircleAvatar(child: Icon(Icons.add)),
            //subtitle: Text('preço = '),
          ),
        );
      },
    );

  }

  Widget _buildMenuCategorias() {
    final cp = getCategorias();
    final menuController = Get.find<MenuProdutosController>();

    return Container(
      height: 130,
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cp.length,
        itemBuilder: (context, index) {
          final isSelected = menuController.produtoIndex.value == index;

          return CategoriaItem(
            nome: cp[index].nome,
            iconPath: cp[index].iconPath,
            isSelected: isSelected,
          );
        },
      ),
    );
  }




}


