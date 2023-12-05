import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/Menu%20Tab/menu_tab_bar_widget.dart';
import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../../Tela Cardapio Digital/controllers/cardapio_controller.dart';
import '../produtos_controller.dart';

class MenuCategoriasScrollGradientWidget extends StatefulWidget {
  final Function(int) onCategorySelected;

  const MenuCategoriasScrollGradientWidget({
    super.key,
    required this.onCategorySelected,
  });

  @override
  State<MenuCategoriasScrollGradientWidget> createState() =>
      _MenuCategoriasScrollGradientWidgetState();
}

class _MenuCategoriasScrollGradientWidgetState
    extends State<MenuCategoriasScrollGradientWidget> {
  //controllers
  final MenuProdutosController menuController =
      Get.put(MenuProdutosController());
  late PageController pc;

  //variaveis
  late List<CategoriaModel> categoriasProdutos;
  bool isLoading = true; // Inicializando diretamente

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemSelecionado = menuController.produtoIndex.value;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        color: CupertinoColors.systemYellow.darkElevatedColor,
        child: Column(
          children: [
            _buildHeader(),
            isLoading
                ? const CircularProgressIndicator()
                : _buildMenuCategorias(),
          ],
        ),
      ),
    );
  }

  //MENU GRADIENTE
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: IconePersonalizado(tipo: Icons.menu),
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
      height: 130,
      padding: const EdgeInsets.all(12),
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
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.5, 1),
              blurRadius: 50,
              spreadRadius: 3,
              color: Colors.yellow.shade300,
            ),
          ],
          gradient: isSelected
              ? LinearGradient(colors: [
                  Colors.deepPurple.shade100,
                  CupertinoColors.activeBlue.highContrastElevatedColor
                ])
              : null,
        ),
        child: Center(
            child: ProdutosDetails(
          nome: categoriasProdutos[index].nome,
          imagem_produto: categoriasProdutos[index].iconPath,
        )),
      ),
    );
  }

  void _onCategoriaTap(int index) {
    setState(() {
      menuController.setProdutoIndex(index); // Atualiza o índice no controller
    });
  }
}
