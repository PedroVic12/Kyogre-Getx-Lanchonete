import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:kyogre_getx_lanchonete/themes%20/cores.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';
import '../../../../../app/widgets/Botoes/float_custom_button.dart';
import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../../../../app/widgets/Utils/loading_widget.dart';
import '../../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../../Carrinho/CarrinhoController.dart';
import '../../../Carrinho/controller/sacola_controller.dart';
import '../DetailsPage/details_page.dart';

class CardsProdutosFIltrados extends StatefulWidget {
  final String categoria_selecionada;

  const CardsProdutosFIltrados(
      {super.key, required this.categoria_selecionada});

  @override
  State<CardsProdutosFIltrados> createState() => _CardsProdutosFIltradosState();
}

class _CardsProdutosFIltradosState extends State<CardsProdutosFIltrados> {
  @override
  Widget build(BuildContext context) {
    // Acessando os controladores
    final RepositoryDataBaseController repositoryController =
        Get.find<RepositoryDataBaseController>();
    final MenuProdutosRepository menuCategorias =
        Get.find<MenuProdutosRepository>();
    final MenuProdutosController menuController =
        Get.find<MenuProdutosController>();
    final CardapioController cardapioController =
        Get.find<CardapioController>();

    var produtos = repositoryController.dataBase_Array;
    var nome_categoria_selecionada = menuCategorias
        .MenuCategorias_Array[menuController.produtoIndex.value].nome;

    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: cor3,
      child: Column(
        children: [
          _headerProdutos(nome_categoria_selecionada),
          displayProdutosFiltradosCategoria(nome_categoria_selecionada),
        ],
      ),
    );
  }

  Widget _headerProdutos(categoria_selecionada) {
    final MenuProdutosController menuController =     Get.find<MenuProdutosController>();
    final MenuProdutosRepository menuCategorias =     Get.find<MenuProdutosRepository>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: CupertinoColors.systemBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(height: 5, color: Colors.black),
          const Icon(CupertinoIcons.arrow_right_square_fill, color: Colors.white),
          const SizedBox(
            width: 16,
          ),
          CustomText(
            text: '${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome}',
            //text: '${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome} - ${menuController.produtoIndex.value}',
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget displayProdutosFiltradosCategoria(String categoria) {
    final CarrinhoPedidoController carrinho =   Get.put(CarrinhoPedidoController());
    final CardapioController cardapioController =  Get.find<CardapioController>();

    // Defina o tamanho do ícone e o espaçamento
    double iconSize = 32;
    double padding = 128;

    // Calcule o raio do CircleAvatar
    double radius = (iconSize / 2) + padding;


    // Exibir um indicador de carregamento enquanto os produtos estão sendo filtrados
    final produtosFiltrados =  cardapioController.repositoryController.filtrarCategoria(categoria);

    var produtosOrdenados = cardapioController.repositoryController.filtrarEOrdenarPorNome(categoria);

    if (produtosOrdenados.isEmpty) {
      return LoadingWidget();
    } else {
      // Exibir a lista de produtos filtrados
      return Expanded(
        child: ListView.builder(
          itemCount: produtosOrdenados.length,
          itemBuilder: (context, index) {
            var produto = produtosOrdenados[index];

            String? pathImg;
            if (produto.imagem != null) {
              List<String>? imagens = produto.imagem?.split('|');
              pathImg = 'lib/repository/assets/FOTOS/${imagens?[0].trim()}';
              cardapioController.pikachu.cout("Img = $pathImg");
            }


            return InkWell(

              onTap: () {
                Get.to(ItemDetailsPage(produto_selecionado: produto,   ));
                //   GetPage(name: '/${produto.nome}', page: ()=> ItemDetailsPage( produto_selecionado: produto));f
              },

              child: Container(
                margin: EdgeInsets.all(6),
                color: Colors.white24,
                height: 100,
                child: Card(
                  elevation: 3,
                  child: Row(
                    children: [
                      //Leading
                      Expanded(flex: 30, child: pathImg != null
                          ? Padding(padding: EdgeInsets.all(6),child:Image.asset(
                        pathImg,
                        fit: BoxFit.fill,
                        //width: ,
                      ))
                          : Center(child: Icon(Icons.fastfood, size: 32)), ),

                      //Title and Subtitle
                      Expanded(flex: 70,child: Row(
                        children: [
                          Expanded(
                            flex: 25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os filhos na vertical
                              crossAxisAlignment: CrossAxisAlignment.start, // Alinha os filhos ao início na horizontal
                              children: [
                                CustomText(
                                  text: '${produto.nome}',
                                  size: 22,
                                  weight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: 'R\$ ${produto.preco_1} Reais',
                                  size: 16,
                                  color: Colors.green,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),


                          //Trailing
                          Expanded(flex: 10,child: BotaoFloatArredondado(
                              icone: CupertinoIcons.plus_circle_fill,
                              onPress: () {
                                carrinho.adicionarCarrinho(produto);

                                cardapioController.repositoryController.pikachu
                                    .loadDataSuccess('Perfeito', 'Item ${produto.nome} adicionado!');


                                // TODO UX FIX cardapioController.toggleBarraInferior();
                              }), )
                        ],
                      ))
                    ],
                  ),
                ),
              )

            );

          },
        ),
      );
    }
  }

  Widget BlurCardWidget(_child, size_w) {
    var _width = MediaQuery.of(context).size.width;

    return GlassContainer(
      height: 150,
      width: _width,
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.40),
          Colors.white.withOpacity(0.10)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.60),
          Colors.white.withOpacity(0.10),
          Colors.lightBlueAccent.withOpacity(0.75),
          Colors.lightBlueAccent.withOpacity(0.6)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.39, 0.40, 1.0],
      ),
      blur: 15.0,
      borderWidth: 1.5,
      elevation: 3.0,
      isFrostedGlass: true,
      shadowColor: Colors.black.withOpacity(0.20),
      alignment: Alignment.center,
      frostedOpacity: 0.12,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: _child,
    );
  }

  Widget _carregandoProdutos() {
    final RepositoryDataBaseController repositoryController =
        Get.find<RepositoryDataBaseController>();

    return FutureBuilder(
      future: repositoryController.getProdutosDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Ocorreu um erro ao carregar os produtos.'));
        } else {
          return Container(
            height: 500,
            color: Colors.purpleAccent,
            child: ListView(
              children: [
                Card(
                    color: Colors.blueGrey,
                    child: Text(
                        'Produtos JSON = ${repositoryController.dataBase_Array}')),
              ],
            ),
          );
        }
      },
    );
  }
}
