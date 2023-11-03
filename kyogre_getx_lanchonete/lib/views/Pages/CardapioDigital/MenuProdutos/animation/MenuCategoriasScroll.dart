import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/display_products.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';
import '../../../../../app/widgets/Custom/CustomText.dart';
import '../produtos_controller.dart';

class MenuCategoriasScrollGradientWidget extends StatefulWidget {
  final Function(int) onCategorySelected;

  const MenuCategoriasScrollGradientWidget({super.key, required this.onCategorySelected});

  @override
  State<MenuCategoriasScrollGradientWidget> createState() => _MenuCategoriasScrollGradientWidgetState();
}

class _MenuCategoriasScrollGradientWidgetState extends State<MenuCategoriasScrollGradientWidget> {

  //variaveis
  late List<CategoriaModel> categoriasProdutos;
  bool isLoading = true;  // Inicializando diretamente

  //controllers
  final MenuProdutosController menuController = Get.put(MenuProdutosController());
  late PageController pc;

  @override
  void initState() {
    super.initState();
    _getCategorias();
  }

  void _getCategorias() async {
    categoriasProdutos = await menuController.fetchCategorias();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        color: CupertinoColors.systemYellow,
        child: Column(
          children: [
            _buildHeader(),
            isLoading ? const CircularProgressIndicator() : _buildMenuCategorias(),

          ],
        ),
      ),
    );
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

  Widget _buildMenuCategorias() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriasProdutos.length,
        itemBuilder: (context, index) {
          return _buildCategoriaItem(context, index);
        },
      ),
    );
  }

  Widget _buildCategoriaItem(BuildContext context, int index) {
    final isSelected = menuController.produtoIndex.value == index;
    return GestureDetector(
      onTap: () => _onCategoriaTap(index),
      child: Container(
        width: 110,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.7, 0),
              blurRadius: 32,
              spreadRadius: 1,
              color: Colors.white,
            ),
          ],
          gradient: isSelected
              ? LinearGradient(colors: [Colors.blue, Colors.purpleAccent.shade400])
              : null,
        ),
        child: Center(
          child: ProdutosDetails(
            nome: categoriasProdutos[index].nome,
            imagem_produto: categoriasProdutos[index].iconPath,
          )
        ),
      ),
    );
  }

  void _onCategoriaTap(int index) {
    setState(() {
      menuController.produtoIndex.value = index;
    });
    menuController.trocarItemSelecionado(index);
    pc.jumpToPage(index);
  }
}
