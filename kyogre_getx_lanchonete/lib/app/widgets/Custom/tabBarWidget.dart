import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
//!Exemplo de uso
//late TabController _tabController;

//_tabController = TabController(length: arrayCategorais.values.legnt, vsync: this); with SingleTickerProviderStateMixin
enum Categorias {
  Home,
  Pesquisa,
}

class TabController {
  late final TabController tabController;

  TabController({required int length, required TickerProvider vsync}) {
    tabController = TabController(length: length, vsync: vsync);
  }

  get control => tabController;
}

class TabBarWidget extends StatelessWidget {
  final TabController controller;
  final List<IconData> icons;
  final List<String> textos;

  const TabBarWidget({
    Key? key,
    required this.controller,
    required this.icons,
    required this.textos,
  }) : super(key: key);

  List<Tab> _buildCategorias(List<IconData> icons, List<String> textos) {
    assert(icons.length == textos.length);

    return List.generate(
      icons.length,
      (index) => Tab(
        icon: Icon(icons[index]),
        text: textos[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabs: _buildCategorias(icons, textos),
        controller: controller.control,
      ),
    );
  }
}

class DisplayTabView extends StatelessWidget {
  const DisplayTabView({Key? key}) : super(key: key);

  List<Map<String, dynamic>> filterByCategoria(
      Categorias categoria, List<Map<String, dynamic>> full) {
    return full.where((item) => item["categoria"] == categoria).toList();
  }

  @override
  Widget build(BuildContext context) {
    var i = 1;
    List categoriaMenu = [
      "Categoria $i",
      "Categoria ${i + 1}",
      "Categoria ${i + 2}",
      "Categoria ${i + 3}"
    ];
    return TabBarView(
      children: [
        for (Categorias categoria in Categorias.values)
          Column(
            children: [
              Text(
                  "Conteúdo da categoria ${categoria.toString().split(".").last}"),
              // Aqui você pode renderizar os itens da categoria
              // Exemplo:
              ListView.builder(
                itemCount: categoriaMenu.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(categoriaMenu[index]),
                    ),
                  );
                },
              ),
            ],
          ),
      ],
    );
  }
}
