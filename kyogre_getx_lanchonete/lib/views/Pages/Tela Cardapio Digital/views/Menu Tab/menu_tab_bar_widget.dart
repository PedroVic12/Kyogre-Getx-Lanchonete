// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/Menu%20Tab/widget_tab.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../../models/DataBaseController/template/produtos_model.dart';
import '../../../CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../../CardapioDigital/MenuProdutos/repository/produtos_model.dart';
import '../cards/CardProdutosFiltrados.dart';

//TODO ROLAR TAB E PROCURAR O INDICE PARA SELECIONAR NO MENU

// TODO CARDAPIO DEPLOY QRCODE

//TODO BOTTOM SHEET

// TODO ITEM PAGE DETAILS

class MenuProdutosController extends GetxController {
  var produtoIndex = 0.obs;

  //metodos
  void setProdutoIndex(int index) {
    produtoIndex.value = index;
    update(); // Notifica os ouvintes de que o estado foi atualizado
    print('Produto atualizado!');
  }

  @override
  void onInit() {
    super.onInit();
  }
}

class MenuTabBarCardapio extends StatefulWidget {
  const MenuTabBarCardapio({super.key});

  @override
  State<MenuTabBarCardapio> createState() => _MenuTabBarCardapioState();
}

class _MenuTabBarCardapioState extends State<MenuTabBarCardapio>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // Assuma que o carregamento dos dados é iniciado em MenuProdutosController.onInit
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Menu Tab Scrol Gradiente
        _buildHeader(),
        Divider(),
        TabBarScrollCardapioCategorias(),

        // TabView
        TabBarViewCardapioProdutosDetails(),
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
    final menuRepositoryCategorias = Get.find<MenuProdutosRepository>();

    var categorias_array = menuRepositoryCategorias.MenuCategorias_Array;

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
        labelPadding: const EdgeInsets.all(4),
        isScrollable: true,
        unselectedLabelColor: Colors.black,
        //indicator: CircleTabIndicator(color: Colors.purpleAccent,radius: 64.0),
        tabs: [
          for (var index = 0; index < categorias_array.length; index++)
            _buildTabBarMenuGradiente(categorias_array[index].nome,
                categorias_array[index].iconPath, index)
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
          width: 110,
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
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
    final MenuProdutosController menuController =
        Get.find<MenuProdutosController>();
    final MenuProdutosRepository menuCategorias =
        Get.find<MenuProdutosRepository>();

    var caregorias = menuCategorias.MenuCategorias_Array;
    final nome_produto_selecionado = menuCategorias
        .MenuCategorias_Array[menuController.produtoIndex.value].nome;
    final indice = menuController.produtoIndex.value;

    // Use MediaQuery para obter o tamanho da tela
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(
          screenSize.height * 0.02), // Exemplo de uso de tamanho relativo
      width: screenSize.width,
      height: screenSize.height,

      child: TabBarView(
        controller: _tabController,
        children: [
          //BlurCardWidget(CardProdutosFiltrados(categoria_selecionada:  menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome), screenSize.height, screenSize.width),
          CardsProdutosFIltrados(
              categoria_selecionada: menuCategorias
                  .MenuCategorias_Array[menuController.produtoIndex.value]
                  .nome),
          CardsProdutosFIltrados(
              categoria_selecionada: menuCategorias
                  .MenuCategorias_Array[menuController.produtoIndex.value]
                  .nome),
          CardsProdutosFIltrados(
              categoria_selecionada: menuCategorias
                  .MenuCategorias_Array[menuController.produtoIndex.value]
                  .nome),
          CardsProdutosFIltrados(
              categoria_selecionada: menuCategorias
                  .MenuCategorias_Array[menuController.produtoIndex.value]
                  .nome),
          CardsProdutosFIltrados(
              categoria_selecionada: menuCategorias
                  .MenuCategorias_Array[menuController.produtoIndex.value]
                  .nome),
        ],
      ),
    );
  }

  Widget buildListRepository() {
    final RepositoryDataBaseController repositoryController =
        Get.find<RepositoryDataBaseController>();

    return Container(
        color: Colors.white,
        height: 300,
        child: Obx(() {
          if (repositoryController.my_array.isEmpty) {
            return LoadingWidget();
          } else {
            setState(() {});
            return ListView.builder(
              itemCount: repositoryController.my_array.length,
              itemBuilder: (context, index) {
                var item = repositoryController.my_array[index];
                return ListTile(
                    subtitle: Column(
                  children: [
                    CustomText(
                      text: '\n\nProduto: ${item.nome}',
                    ),
                    CustomText(text: 'Categoria: ${item.categoria}'),
                    CustomText(text: 'Precos: ${item.precos}')
                  ],
                ));
              },
            );
          }
        }));
  }

  Widget BlurCardWidget(_child, size_h, size_w) {
    return GlassContainer(
      height: size_h,
      width: size_w,
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.40),
          Colors.white.withOpacity(0.10)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.60),
          Colors.white.withOpacity(0.10),
          Colors.lightBlueAccent.withOpacity(0.05),
          Colors.lightBlueAccent.withOpacity(0.6)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.39, 0.40, 1.0],
      ),
      blur: 15.0,
      borderWidth: 1.5,
      elevation: 3.0,
      isFrostedGlass: true,
      shadowColor: Colors.black.withOpacity(0.20),
      alignment: Alignment.center,
      frostedOpacity: 0.12,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: _child,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
