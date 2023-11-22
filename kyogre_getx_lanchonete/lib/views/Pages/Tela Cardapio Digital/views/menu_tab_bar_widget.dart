// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/widget_tab.dart';

import '../../../../app/widgets/Custom/CustomText.dart';
import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../models/DataBaseController/template/produtos_model.dart';
import '../../CardapioDigital/MenuProdutos/Cards/card_produto_selecionado.dart';
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

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
    // Assuma que o carregamento dos dados é iniciado em MenuProdutosController.onInit
  }

  @override
  Widget build(BuildContext context) {



    return      Column(
      children: [

        // Menu Tab Scrol Gradiente
        _buildHeader(),
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

   var categorias_array =  menuRepositoryCategorias.MenuCategorias_Array;

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
        indicator: CircleTabIndicator(color: Colors.purpleAccent,radius: 72.0),
        tabs: [
          for (var index = 0;  index < categorias_array.length; index++)
            _buildTabBarMenuGradiente(
                categorias_array[index].nome,
                categorias_array[index].iconPath,
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

    final MenuProdutosController menuController =Get.find<MenuProdutosController>();
    final MenuProdutosRepository menuCategorias = Get.find<MenuProdutosRepository>();


    // Use MediaQuery para obter o tamanho da tela
    final screenSize = MediaQuery.of(context).size;

    var categoria = menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome;

    return Container(
      padding: EdgeInsets.all(screenSize.height * 0.02), // Exemplo de uso de tamanho relativo
      width: screenSize.width,
      height: screenSize.height,

      child:   TabBarView(
        controller: _tabController,
        children: [

          CardProdutoCardapioSelecionado(produtoSelecionado: 'Hamburguer'),
          CardProdutosFiltrados(categoria_selecionada: 'Hamburguer'),
          CardProdutoCardapioSelecionado(produtoSelecionado: 'Pizzas'),
          CardProdutosFiltrados(categoria_selecionada: categoria),
          CardProdutosFiltrados(categoria_selecionada: categoria),

        ],
      ),

    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
