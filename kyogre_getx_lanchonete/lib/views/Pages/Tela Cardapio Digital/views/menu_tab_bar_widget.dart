// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/Custom/CustomText.dart';
import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../models/DataBaseController/template/produtos_model.dart';
import '../../CardapioDigital/MenuProdutos/Cards/card_produto_selecionado.dart';
import '../../CardapioDigital/MenuProdutos/Tab Bar/views/folear_cardapio_produtos.dart';
import '../../CardapioDigital/MenuProdutos/Tab Bar/widgets.dart';
import '../../CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../CardapioDigital/MenuProdutos/repository/produtos_model.dart';
import 'CardProdutosFiltrados.dart';

//TODO SPLASH PAGE CARREGANDO

// TODO CARDAPIO FIX

// TODO CARDAPIO DEPLOY QRCODE

//TODO BOTTOM SHEET

// TODO ITEM PAGE DETAILS

class MenuTabBarCardapio extends StatefulWidget {
  const MenuTabBarCardapio({super.key});

  @override
  State<MenuTabBarCardapio> createState() => _MenuTabBarCardapioState();
}

class _MenuTabBarCardapioState extends State<MenuTabBarCardapio>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final MenuProdutosController menuController =
      Get.put(MenuProdutosController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // Assuma que o carregamento dos dados é iniciado em MenuProdutosController.onInit
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (menuController.isLoading.value) {
        return Center(
            child: Column(
          children: [
            CircularProgressIndicator(),
            CustomText(
                text: 'Carregou? = ${menuController.isLoading.value}',
                size: 16),
          ],
        ));
      } else {
        return buildTabBarLayout();
      }
    });
  }

  //! Layout
  Widget buildTabBarLayout() {
    return Column(
      children: [
        _buildHeader(),
        TabBarScrollCardapioCategorias(),
        CustomText(text: 'Escolha entre os produtos: {produto.nome}'),
        displayProdutos(2),
        //Expanded(          child: TabBarViewCardapioProdutosDetails(),        )
      ],
    );
  }

  //! Menu Scroll Lateral
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
            icon: IconePersonalizado(tipo: Icons.menu),
          ),
          const SizedBox(width: 16),
          const CustomText(
            text: 'Categorias de Lanches',
            size: 24,
            weight: FontWeight.bold,
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget TabBarScrollCardapioCategorias() {
    final menuController = Get.find<MenuProdutosController>();
    final MenuProdutosRepository repository = Get.put(MenuProdutosRepository());

    //var categoriasProdutos =  repository.fetchCategorias();

    return Container(
      margin: EdgeInsets.all(6),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CupertinoColors.activeOrange,
            CupertinoColors.systemYellow.darkHighContrastElevatedColor
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.7, 1),
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
        indicator:
            CircleTabIndicator(color: Colors.purpleAccent.shade700, radius: 64),
        tabs: [
          for (var index = 0;
              index < menuController.categoriasProdutosMenu.length;
              index++)
            _buildTabBarMenuGradiente(
                menuController.categoriasProdutosMenu[index].nome,
                menuController.categoriasProdutosMenu[index].iconPath,
                index)
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
          _tabController.animateTo(
              index); // Adicione isso para sincronizar com TabController
        },
        child: Container(
          width: 120,
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0.5, 1),
                blurRadius: 5,
                spreadRadius: 2,
                color: Colors.yellow,
              ),
            ],
            gradient: isSelected
                ? LinearGradient(colors: [Colors.greenAccent, Colors.green])
                : LinearGradient(colors: [
                    Colors.deepPurple.shade100,
                    CupertinoColors.activeBlue.highContrastElevatedColor
                  ]),
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

  //! CARDS PRODUTOS
  Widget TabBarViewCardapioProdutosDetails() {
    var categoriaSelecionada = menuController
        .categoriasProdutosMenu[menuController.produtoIndex.value];

    return Container(
      margin: const EdgeInsets.all(6),
      height: 500,
      width: 500,
      child: TabBarView(
        controller: _tabController,
        children: [
          //1
          FolearCardapioDigital(
            content: displayProdutosFiltradosCategoria('Pizzas'),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },
          ),

          //2
          FolearCardapioDigital(
            content: Container(
              color: Colors.greenAccent,
              child: CardProdutosFiltrados(),
            ),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },
          ),

          //3
          Obx(() => CardProdutoCardapioSelecionado(
              produtoSelecionado: menuController
                  .categoriasProdutosMenu[menuController.produtoIndex.value]
                  .nome)),

          //4
          FolearCardapioDigital(
            content: CardProdutoCardapioSelecionado(
              produtoSelecionado: categoriaSelecionada.nome,
            ),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },
          ),

          //5
          FolearCardapioDigital(
            content: CardProdutoCardapioSelecionado(
              produtoSelecionado: 'Hamburguer',
              //produtoSelecionado: categoriaSelecionada.nome,
            ),
            onPageChanged: (int index) {
              final menuController = Get.find<MenuProdutosController>();
              menuController.setProdutoIndex(index);
              _tabController.animateTo(index);
            },
          ),
        ],
      ),
    );
  }

  Widget displayProdutosFiltradosCategoria(String categoria) {
    final RepositoryDataBaseController _repositoryController =
        Get.put(RepositoryDataBaseController());
    return FutureBuilder<List<ProdutoModel>>(
      future: _repositoryController.filtrarCategoria(categoria),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
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
                subtitle:
                    Text('Ingredientes: ${produto.ingredientes?.join(', ')}'),
                trailing: Text(
                    'Preços: ${produto.precos.map((p) => p['preco']).join(', ')}'),
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
