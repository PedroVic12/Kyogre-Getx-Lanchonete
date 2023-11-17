import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/float_custom_button.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/Tab%20Bar/widgets.dart';
import '../../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../../models/DataBaseController/template/produtos_model.dart';
import '../../../Carrinho/CarrinhoController.dart';
import '../../../Tela Cardapio Digital/views/CardProdutosFiltrados.dart';
import '../Cards/card_produto_selecionado.dart';
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
  final MenuProdutosController menuController = Get.find<MenuProdutosController>();
  final CatalogoProdutosController catalogoController = Get.find<CatalogoProdutosController>();



  void cout(msg){
    print('\n\n======================================================');
    print(msg);
    print('======================================================');

  }

  void _handlePageChange(int index) {
    if (_tabController.index != index) {
      _tabController.animateTo(index);
    }
  }


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        menuController.setProdutoIndex(_tabController.index);
        _tabController.animateTo(_tabController.index);  // Adicione isso para sincronizar com TabController

      }

    });

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

      ],
    );
  }


  // MENU LATERAL SCROL GRADIENTE COM AS CATEGORIAS
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
          _tabController.animateTo(index);  // Adicione isso para sincronizar com TabController
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
            onPressed: () {
             CupertinoAlertDialog(
               title: Text('ola'),
             );
            },
            icon:  IconePersonalizado(tipo: Icons.menu),
          ),
          const SizedBox(width: 16),
          const CustomText(
            text: 'Categorias de Lanches',
            size: 24,
            weight: FontWeight.bold,
          ),
          Divider(color: Colors.black,)

        ],
      ),
    );
  }



  // TODO CARDS PRODUTOS
  Widget TabBarViewCardapioProdutosDetails() {

    var categoriaSelecionada = menuController.categoriasProdutosMenu[menuController.produtoIndex.value];

    return  Container(
      margin: const EdgeInsets.all(6),
      height: 800,
      color: Colors.white,
      child: TabBarView(
        controller: _tabController,
        children: [
          FolearCardapioDigital(

            content: displayProdutosFiltradosCategoria('Pizzas'),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },),

          FolearCardapioDigital(
            content: Container(color: Colors.greenAccent,child: CardProdutosFiltrados()  ,),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },),

        Obx(() => CardProdutoCardapioSelecionado(produtoSelecionado: menuController.categoriasProdutosMenu[menuController.produtoIndex.value].nome)),


          FolearCardapioDigital(
            content: displayProdutos(menuController.produtoIndex.value),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },),

          FolearCardapioDigital(
            content: CardProdutoCardapioSelecionado(
              produtoSelecionado: categoriaSelecionada.nome,
            ),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },),
        ],),
    );
  }

  Widget displayProdutosFiltradosCategoria(String categoria) {
    final RepositoryDataBaseController _repositoryController = Get.find<RepositoryDataBaseController>();

    return FutureBuilder<List<ProdutoModel>>(
      future: _repositoryController.filtrarCategoria(categoria),
      builder: (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var produto = snapshot.data![index];
              return ListTile(
                title: Text(produto.nome),
                subtitle: Text('Ingredientes: ${produto.ingredientes?.join(', ')}'),
                trailing: Text('Preços: ${produto.precos.map((p) => p['preco']).join(', ')}'),
              );
            },
          );
        } else {
          return Text('Nenhum dado disponível');
        }
      },
    );
  }



  Widget displayProdutos(int index) {
    final menuController = Get.find<MenuProdutosController>();
    var produto = menuController.categoriasProdutosMenu[index];

    return Center(
      child: Text(
        'Produto: ${produto.nome}',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }



  Widget _indexProdutoSelecionado(){

    final MenuProdutosController menuController = Get.find<MenuProdutosController>();

    return Container(
        color: Colors.black,
        child: Obx(() => Center(child: Column(children: [
          CustomText(text: 'item selecionado = ${menuController.produtoIndex}',color: Colors.white,),
          CustomText(text: 'item selecionado = ${menuController.categoriasProdutosMenu[menuController.produtoIndex.value].nome}',color: Colors.white,),
        ],))));
  }
}


