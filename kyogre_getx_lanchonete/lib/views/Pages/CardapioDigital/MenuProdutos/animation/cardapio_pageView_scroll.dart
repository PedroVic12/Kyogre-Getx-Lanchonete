import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/produtos_model.dart';



class CarPage extends StatelessWidget {
   CarPage({super.key});
  final menuController = Get.put(MenuProdutosController()); // Encontre a instância existente do controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cardápio')),
      body: Obx(() {
        if (menuController.categorias_produtos_carregados.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          // Teste com um widget simples primeiro.
          return ListView.builder(
            itemCount: menuController.categorias_produtos_carregados.length,
            itemBuilder: (context, index) {
              final categoria = menuController
                  .categorias_produtos_carregados[index];
              return ListTile(
                title: Text(categoria.nome),
              );
            },
          );
        }
      }),
    );
  }
}

class CardDisplayProdutos extends StatefulWidget {
  @override
  _CardDisplayProdutosState createState() => _CardDisplayProdutosState();
}

class _CardDisplayProdutosState extends State<CardDisplayProdutos> {
  late PageController pageController;
  late MenuProdutosController menuController;

  @override
  void initState() {
    super.initState();
    menuController = Get.put(MenuProdutosController()); // Encontre a instância existente do controlador
    pageController = PageController(initialPage: menuController.produtoIndex.value);

    // Acompanhar alterações no produtoIndex e mover o PageView para a página correta
    ever(menuController.produtoIndex, (int index) {
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Certifique-se de que o PageView seja atualizado para refletir o índice do produto atual
      if (pageController.hasClients && menuController.produtoIndex.value != pageController.page?.round()) {
        // Coloca em um microtask para mudar de página fora do processo de construção atual
        WidgetsBinding.instance.addPostFrameCallback((_) {
          pageController.jumpToPage(menuController.produtoIndex.value);
        });
      }

      return Container(
        child: Column(
          children: [
            myCard3(),
            Expanded( // Certifique-se de que o PageView é envolvido por um Expanded
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  // Atualiza o produtoIndex quando a página é alterada pelo usuário
                  menuController.produtoIndex.value = index;
                },
                itemCount: menuController.categorias_produtos_carregados.length,
                itemBuilder: (context, index) {
                  return _buildProdutoPage(menuController.categorias_produtos_carregados[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProdutoPage(CategoriaModel categoria) {
    return Center(
      child: Card(
        child: ListTile(
          title: Text('Selecionado = ${categoria.nome}'),
          trailing: Text('Índice = ${menuController.produtoIndex.value}'),
        ),
      ),
    );
  }

  Widget myCard3() {
    // Certifique-se de que os dados estão sendo carregados corretamente.
    if (menuController.categorias_produtos_carregados.isEmpty) {
      // Se estiver vazio, você pode querer mostrar um indicador de carregamento ou uma mensagem.
      return CircularProgressIndicator();
    }

    final categoriaProduto = menuController.categorias_produtos_carregados[menuController.produtoIndex.value];
    return Card(
      child: CupertinoListTile(
        title: Text('Selecionado = ${categoriaProduto.nome}'),
        trailing: Text('Índice = ${menuController.produtoIndex.value}'), // Corrigido para usar .value
      ),
    );
  }


  @override
  void dispose() {
    pageController.dispose(); // Descartar o controlador da página
    super.dispose();
  }
}
