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

class MenuTabBarCardapio extends StatefulWidget {
  const MenuTabBarCardapio({super.key});

  @override
  State<MenuTabBarCardapio> createState() => _MenuTabBarCardapioState();
}

class _MenuTabBarCardapioState extends State<MenuTabBarCardapio>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoadingTabView =      true;
  final CardapioController controller = Get.put(CardapioController());
  final MenuProdutosController menuController =   Get.put(MenuProdutosController());

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
    if (_tabController.indexIsChanging || _tabController.index != menuController.produtoIndex.value) {
      menuController.setProdutoIndex(_tabController.index);
      setState(() {}); // Isso forçará a reconstrução do widget para refletir a nova seleção
    }
  }
  void selecionarLista([int? selectedIndex]) {
    int newIndex = selectedIndex ?? _tabController.index;

    if (newIndex != menuController.produtoIndex.value) {
      menuController.setProdutoIndex(newIndex);
      _tabController.animateTo(newIndex); // Isso garantirá que a aba correta seja selecionada no TabBar.
      setState(() {}); // Isso forçará a reconstrução do widget para refletir a nova seleção.
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
                builder: (context) => CupertinoAlertDialog(
                  actions: [
                    CupertinoDialogAction(
                        child: const CustomText(text:'Fechar', weight: FontWeight.bold,),
                        onPressed: () => Get.back()
                    ),
                  ],
                  title: CustomText(text: 'Selecione uma categoria'),
                  content: Container(
                    height: 200, // Defina uma altura fixa para o ListView
                    child: ListView.builder(
                      itemCount: controller.menuCategorias.MenuCategorias_Array.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelectedHeader = menuController.produtoIndex.value == index;

                        return Material(
                            color: Colors.grey.shade300,
                            child: Column(children: [
                              ListTile(
                                focusColor: Colors.green,
                                title: CustomText(text:controller.menuCategorias.MenuCategorias_Array[index].nome, color: isSelectedHeader ? Colors.green : Colors.black),
                                onTap: () {
                                  selecionarLista(index);
                                  //Get.back();
                                },
                              ),
                              Divider(height: 5,color: Colors.black,)
                            ],)
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [CupertinoColors.activeOrange, cor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.7, 1),
            blurRadius: 50,
            spreadRadius: 1,
            color: Colors.yellow,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6), // Ajuste o espaçamento à esquerda aqui
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          isScrollable: true,
          unselectedLabelColor: Colors.black,
          // Mantenha o labelPadding padrão ou ajuste conforme necessário
          labelPadding: EdgeInsets.all(6),
          tabs: List<Widget>.generate(
            controller.menuCategorias.MenuCategorias_Array.length,
                (index) {
              var categoria = controller.menuCategorias.MenuCategorias_Array[index];
              return _buildTabBarMenuGradiente(categoria.nome, categoria.iconPath ?? categoria.img, index);
            },
          ),
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
          width: 115,
          height: 80,

          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
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
