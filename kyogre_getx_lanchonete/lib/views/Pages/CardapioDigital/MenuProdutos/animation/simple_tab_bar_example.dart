import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Tab Bar/views/folear_cardapio_produtos.dart';
import '../produtos_controller.dart';

class MySimpleTabBarWidget extends StatefulWidget {
  @override
  _MySimpleTabBarWidgetState createState() => _MySimpleTabBarWidgetState();
}

class _MySimpleTabBarWidgetState extends State<MySimpleTabBarWidget> with TickerProviderStateMixin {
  late TabController _tabController;
  final menuController = Get.find<MenuProdutosController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        menuController.setProdutoIndex(_tabController.index);
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Tab 1"),
            Tab(text: "Tab 2"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFolearCardapioDigital(0),
          _buildFolearCardapioDigital(1),
        ],
      ),
    );
  }

  Widget _buildFolearCardapioDigital(int index) {
    return FolearCardapioDigital(
      content: Center(child: Text("Índice: $index")),
      onPageChanged: (int newIndex) {
        if (_tabController.index != newIndex) {
          _tabController.animateTo(newIndex);
          final menuController = Get.find<MenuProdutosController>();
          menuController.setProdutoIndex(newIndex);
        }
      },
    );
  }

}
