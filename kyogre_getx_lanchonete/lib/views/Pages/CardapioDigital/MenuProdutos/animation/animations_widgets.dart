import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/animation/page_flip.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/cards_produtos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/view/MenuCategoriasScroll.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:page_flip/page_flip.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';

class PageFlipExemplo extends StatefulWidget {
  const PageFlipExemplo({super.key});

  @override
  State<PageFlipExemplo> createState() => _PageFlipExemploState();
}

class _PageFlipExemploState extends State<PageFlipExemplo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageFlipWidget(
        backgroundColor: Colors.grey,
        lastPage: const Center(
          child: Text('Última Página'),
        ),
        duration: Duration(seconds: 1),
        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: CustomText(
                text: 'Produto 1',
                size: 30,
              ),
            ),
            // Add more details from the product as needed
          ),
          Container(
            color: Colors.grey,
            child: Center(
              child: CustomText(
                text: 'Produto 2',
                size: 30,
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: CustomText(
                text: 'Produto 3',
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScrolPageView extends StatefulWidget {
  const ScrolPageView({super.key});

  @override
  State<ScrolPageView> createState() => _ScrolPageViewState();
}

class _ScrolPageViewState extends State<ScrolPageView> {
  late AnimationController _controller;

  int paginaAtual = 0;
  late PageController pc;

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: PageView(
            controller: pc,
            onPageChanged: setPaginaAtual,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: [CarrinhoPage(), DashboardPage()],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Carrinho'),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
          ],
          onTap: (value) {
            setState(() {
              paginaAtual = value;
              pc.animateToPage(paginaAtual,
                  duration: Duration(milliseconds: 1000), curve: Curves.ease);
            });
          },
        ));
  }
}
