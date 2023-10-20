
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/ItemPage/itemPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import '../../../../app/widgets/Custom/CustomText.dart';
import '../CatalogoProdutos/CatalogoProdutosController.dart';

class IconePersonalizado extends StatelessWidget {
  IconData tipo;

  IconePersonalizado({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      child: CircleAvatar(
        child: Icon(tipo, size: 18),
      ),
    );
  }
}

class MenuCategoriasScrollGradientWidget extends StatefulWidget {
  const MenuCategoriasScrollGradientWidget({super.key});

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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32)),
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
                ],
              ),
            ),
            _isLoading
                ? CircularProgressIndicator()
                : MenuCategorias(),
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
            },
            child: Container(
              width: 110,
              height: 50,
              margin:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
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


class DetalhesProdutosCard extends StatefulWidget {
  final Key? key;

  const DetalhesProdutosCard({this.key}): super(key: key);

  @override
  State<DetalhesProdutosCard> createState() => _DetalhesProdutosCardState();
}

class _DetalhesProdutosCardState extends State<DetalhesProdutosCard> {


  // Controladores
  final MenuProdutosController menuController = Get.put(MenuProdutosController());
  final CatalogoProdutosController catalogoProdutosController = Get.put(CatalogoProdutosController());
  final CarrinhoController carrinhoController = Get.put(CarrinhoController());

  Future<void> loadProducts() async {
    await Future.delayed(Duration(seconds: 1));
    menuController.isLoading.value = false;
    _productsLoader.complete(); // Complete o completer após o carregamento.
  }

  final _productsLoader = Completer<void>();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding DetalhesProdutosCard");

// Variável para armazenar o nome do produto
    String nomeProduto = '';
    var categoria_selecionada = catalogoProdutosController.selectedCategoryIndex.value;
    var categoria = catalogoProdutosController.catalogoCategorias;
    var itemProduto = menuController.categorias_produtos_carregados;
    var produtoSelecionado = itemProduto[menuController.produtoIndex.value];
    var produtos = catalogoProdutosController.produtos;

    // UI
    return FutureBuilder(
      future: _productsLoader.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }else {

          return Obx(() => Container(
            padding: EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: produtos.map((produto) =>

                    GestureDetector(
                        child: Column(
                          children: [
                            //Obx(() => CustomText(text: itemProduto[menuController.produtoIndex.value].nome,)),  // Obx aqui
                            //CustomText(text: categoria[menuController.produtoIndex.value]),
                            //CustomText(text: '${menuController.produtoIndex}'),

                            GetBuilder<CatalogoProdutosController>(
                              builder: (controller) {

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Obx(() => ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.produtos.length,
                                      itemBuilder: (context, index) {
                                        Produto produto = controller.produtos[index];
                                        return Card(
                                          margin: EdgeInsets.only(bottom: 20),
                                          color: Colors.blueGrey.shade100,
                                          child: ListTile(
                                            title: CustomText(text: produto.nome,size: 20,),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (produto.preco != null) ...[
                                                  if (produto.preco!.preco1 != null)
                                                    CustomText(text: 'R\$ ${produto.preco!.preco1}', color: Colors.green, weight: FontWeight.bold, size: 18,),
                                                  if (produto.preco!.preco2 != null)
                                                    Text('Preço 2: R\$ ${produto.preco!.preco2}'),
                                                ],
                                                // Adicione mais detalhes sobre o produto aqui
                                              ],
                                            ),
                                            leading: Icon(Icons.fastfood),  // Um ícone para indicar que este é um produto
                                            trailing: IconButton(
                                              icon: Icon(Icons.add_box_sharp, color: Colors.blue,size: 36),  // Um botão para adicionar o produto ao carrinho
                                              onPressed: () {
                                                carrinhoController.adicionarProduto(produto);                        },
                                            ),
                                          ),
                                        );
                                      },
                                    ))
                                  ],
                                );
                              },
                            ),

                          ],
                        ),

                        onTap: (){
                          Get.to(ItemPage(),transition: Transition.leftToRightWithFade);
                        }
                    ),
                ).toList()
            ),
          ));
      }
      },
    );

    }
}



class AnimatedProduct extends StatelessWidget {
  final Widget child;
  final bool leftToRight;
  final String keyValue;

  AnimatedProduct({required this.child, this.leftToRight = true, required this.keyValue});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 3000),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: leftToRight ? Offset(-1, 0) : Offset(1, 0),
          end: Offset(0, 0),
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      child: KeyedSubtree(key: ValueKey(keyValue), child: child),
    );



  }
}
