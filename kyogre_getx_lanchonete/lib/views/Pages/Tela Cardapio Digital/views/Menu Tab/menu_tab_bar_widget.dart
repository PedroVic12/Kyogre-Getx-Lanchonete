// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/Menu%20Tab/widget_tab.dart';
import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../../../../themes /cores.dart';
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

  final MenuProdutosController menuGradiente = Get.put(MenuProdutosController());
  final CardapioController controller = Get.put(CardapioController());


  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: controller.menuCategorias.MenuCategorias_Array.length,
        //length: 5,
        vsync: this);
    // Assuma que o carregamento dos dados é iniciado em MenuProdutosController.onInit


  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        // Menu Tab Scrol Gradiente
        _buildHeader(),
        Obx(() {
        if(controller.menuCategorias.MenuCategorias_Array.isEmpty){
           return CircularProgressIndicator();
        } else {
          return  TabBarScrollCardapioCategorias();
        }
        }),

        // TabView
        TabBarViewCardapioProdutosDetails()
      ],
    );
  }

  //! Menu Scroll Lateral
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
            },
            icon: IconePersonalizado(tipo: Icons.menu),
          ),
          const SizedBox(width: 16),
          const CustomText(
            text: 'Categorias de Lanches',
            size: 20,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget TabBarScrollCardapioCategorias() {

    return  Container(
      margin: EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CupertinoColors.activeOrange,
            cor2
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
          for (var index = 0; index <     controller.menuCategorias.MenuCategorias_Array.length; index++)
            _buildTabBarMenuGradiente( controller.menuCategorias.MenuCategorias_Array[index].nome,
                controller.menuCategorias.MenuCategorias_Array[index].iconPath, index)
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
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(30),
            boxShadow:  const [
              BoxShadow(
                offset:  Offset(0.5, 1),
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
    List<ProdutoModel> produtosCarregados = controller.repositoryController.dataBase_Array;
    final indice = menuGradiente.produtoIndex.value;

    // Use MediaQuery para obter o tamanho da tela
    final screenSize = MediaQuery.of(context).size;

    return Obx(() {
      return Container(
        padding: EdgeInsets.all(
            screenSize.height * 0.02), // Exemplo de uso de tamanho relativo
        width: screenSize.width,
        height: screenSize.height,

        child:  TabBarView(
          controller: _tabController,
          children: [
            //BlurCardWidget(CardProdutosFiltrados(categoria_selecionada:  menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome), screenSize.height, screenSize.width),
            for (var index = 0; index < produtosCarregados.length; index++)
              CardsProdutosFIltrados(categoria_selecionada: produtosCarregados[index].nome),

          ],
        ),
      );
    });
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
