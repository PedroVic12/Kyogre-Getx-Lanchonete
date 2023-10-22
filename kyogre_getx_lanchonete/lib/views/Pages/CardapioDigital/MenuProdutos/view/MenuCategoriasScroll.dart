import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/ItemPage/itemPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/page_flip.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../CatalogoProdutos/CatalogoProdutosController.dart';

class IconePersonalizado extends StatelessWidget {
  IconData tipo;

  IconePersonalizado({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: CircleAvatar(
        child: Icon(tipo, size: 32),
      ),
    );
  }
}

class MenuCategoriasScrollGradientWidget extends StatefulWidget {
  final Function(int) onCategorySelected;

  const MenuCategoriasScrollGradientWidget({super.key, required this.onCategorySelected});

  @override
  State<MenuCategoriasScrollGradientWidget> createState() =>
      _MenuCategoriasScrollGradientWidgetState();
}

class _MenuCategoriasScrollGradientWidgetState
    extends State<MenuCategoriasScrollGradientWidget> {
  List<CategoriaModel> categorias_produtos = [];

  // Obtenha a categoria
  final MenuProdutosController menuController =
      Get.put(MenuProdutosController());

  // Carregamento
  bool _isLoading = true; // Defina como true para indicar que está carregando.

  void _getCategorias() {
    categorias_produtos = menuController.fetchCategorias();
    setState(() {
      _isLoading =
          false; // Quando os dados estiverem prontos, defina como false.
    });
    print(categorias_produtos);
  }

  @override
  void initState() {
    super.initState();
    // Chame _getCategorias no initState para carregar os dados.
    _getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        color: CupertinoColors.systemYellow,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              alignment: Alignment.topCenter,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: IconePersonalizado(tipo: Icons.menu),
                  ),
                  SizedBox(width: 16),
                  CustomText(
                    text: 'Categorias de Lanches',
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                  Divider()
                ],
              ),
            ),
            _isLoading ? CircularProgressIndicator() : MenuCategorias(),
          ],
        ),
      ),
    );
  }

  Widget MenuCategorias() {
    return Container(
      height: 150,
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorias_produtos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                menuController.produtoIndex.value = index;

                print('Produto ${menuController.produtoIndex.value}');
              });
              // Quando uma categoria for selecionada, atualize os detalhes do produto
              menuController.trocarItemSelecionado(index);

              //TESTE
              widget.onCategorySelected(index);
            },
            child: Container(
              width: 110,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.5, 0),
                    blurRadius: 32,
                    spreadRadius: 1,
                    color: Colors.white,
                  ),
                ],
                gradient: menuController.produtoIndex == index
                    ? const LinearGradient(
                        colors: [Colors.indigoAccent, Colors.purpleAccent])
                    : null,
              ),
              child: ProdutosDetails(
                nome: categorias_produtos[index].nome,
                imagem_produto: categorias_produtos[index].iconPath,
              ),
            ),
          );
        },
      ),
    );
  }
}
