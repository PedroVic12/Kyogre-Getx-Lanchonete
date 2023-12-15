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

class MenuTabBarCardapio extends StatefulWidget {
  const MenuTabBarCardapio({super.key});

  @override
  State<MenuTabBarCardapio> createState() => _MenuTabBarCardapioState();
}

class _MenuTabBarCardapioState extends State<MenuTabBarCardapio>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoadingTabView =
      true; // Variável para controlar o estado de carregamento
  final CardapioController controller = Get.put(CardapioController());
  final MenuProdutosController menuController =
      Get.put(MenuProdutosController());

  @override
  void initState() {

    controller.setupCardapioDigitalWeb().then((_) {
      if (mounted) {
        setState(() {
          _tabController = TabController(
            length: controller.menuCategorias.MenuCategorias_Array.length,
            vsync: this,
          );
          _isLoadingTabView = false;
        });

        // Adicionar um listener para sincronizar a mudança de categoria com a exibição de produtos
        _tabController.addListener(_handleTabSelection);
      }
    });
  }




  void _handleTabSelection() {

    controller.pikachu.cout('Menu atual = ${menuController.produtoIndex.value}');

    if (_tabController.indexIsChanging) {
      menuController.setProdutoIndex(_tabController.index);
      setState(() {}); // Isso forçará a reconstrução do widget para refletir a nova seleção
    }
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_isLoadingTabView) {
        return LoadingWidget();
      } else {
        return Column(
          children: [
            // Menu Tab Scrol Gradiente
            _buildHeader(),
            TabBarScrollCardapioCategorias(),

            // TabView
            Expanded(child: TabBarViewCardapioProdutosDetails())
          ],
        );
      }
    });
  }

  //! Menu Scroll Lateral
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(onPressed: () => Get.back(), child: Text('Fechar'))
                  ],
                  title: CustomText(text: 'Selecione uma categoria'),
                  contentPadding: const EdgeInsets.all(12),
                  content: SizedBox(
                    height: 200, // Defina uma altura fixa para o ListView
                    child: ListView.builder(
                      itemCount: controller.menuCategorias.MenuCategorias_Array.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(controller.menuCategorias.MenuCategorias_Array[index].nome),
                          onTap: () {
                            // Adicione a lógica para selecionar a categoria aqui
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
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
    return Container(
      margin: EdgeInsets.all(6),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CupertinoColors.activeOrange, cor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.7, 1),
            blurRadius: 60,
            spreadRadius: 3,
            color: Colors.yellow,
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        labelPadding: EdgeInsets.all(6),
        isScrollable: true,
        unselectedLabelColor: Colors.black,
        tabs: List<Widget>.generate(
          controller.menuCategorias.MenuCategorias_Array.length,
              (index) {
            var categoria = controller.menuCategorias.MenuCategorias_Array[index];

            return _buildTabBarMenuGradiente(
              categoria.nome,
              categoria.iconPath ?? categoria.img,
              index,
            );
          },
        ),
      ),

    );
  }

  Widget _buildTabBarMenuGradiente(String nome, Widget? iconPath, int index) {
    return Obx(() {
      bool isSelected = menuController.produtoIndex.value == index;

      return GestureDetector(
        onTap: () {
          menuController.setProdutoIndex(index);
          _tabController.animateTo(index);
        },
        child: Container(
          width: 110,
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.5, 1),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconPath != null) ...[
                  iconPath, // Renderiza o widget (Icon ou Image)
                  SizedBox(height: 5),
                ],

                CustomText(text: nome,color: isSelected ? Colors.white : Colors.black,size: 13,)
              ],
            ),
          ),
        ),
      );
    });
  }


  //! CARDS PRODUTOS

  Widget TabBarViewCardapioProdutosDetails() {
    return Obx(() {
      return TabBarView(
        controller: _tabController,
        children: controller.menuCategorias.MenuCategorias_Array.map((categoria) {
          return CardsProdutosFIltrados(categoria_selecionada: categoria.nome);
        }).toList(),
      );
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
