import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/pikachu_controller.dart';

import '../../../../app/widgets/Botoes/float_custom_button.dart';
import '../../../../app/widgets/Custom/CustomText.dart';
import '../../../../app/widgets/Utils/loading_widget.dart';
import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../models/DataBaseController/template/produtos_model.dart';
import '../../CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import '../../Carrinho/CarrinhoController.dart';



class CardProdutosFiltrados extends StatelessWidget {

  final String categoria_selecionada;

   CardProdutosFiltrados({super.key, required this.categoria_selecionada});


  @override
  Widget build(BuildContext context) {
    // Acessando os controladores
    final RepositoryDataBaseController repositoryController = Get.find<RepositoryDataBaseController>();
    final CarrinhoController carrinhoController = Get.find<CarrinhoController>();
    final MenuProdutosRepository menuCategorias = Get.find<MenuProdutosRepository>();
    final MenuProdutosController menuController =Get.find<MenuProdutosController>();
    final pikachu = PikachuController();


    var produtos = repositoryController.dataBase_Array;
    var nome_categoria_selecionada = menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome;

    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.deepOrangeAccent,
      child: Column(
        children: [
          _headerProdutos(nome_categoria_selecionada),
          
          displayProdutosFiltradosCategoria(nome_categoria_selecionada)
        ],
      ),
    );





  }

  Widget _headerProdutos(categoria_selecionada) {

    final MenuProdutosController menuController =Get.find<MenuProdutosController>();
    final MenuProdutosRepository menuCategorias = Get.find<MenuProdutosRepository>();



    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: CupertinoColors.systemBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Divider(height: 10, color: Colors.grey),
          Icon(CupertinoIcons.search, color: Colors.white),
          SizedBox(width: 16,),
          CustomText(
            text: 'Item selecionado = ${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome}',
            color: Colors.white,
            size: 18,
          ),

          CustomText(text: 'Categoria = ${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value]}',          color: Colors.white,         size: 18,         ),
        ],
      ),
    );
  }



  Widget displayProdutosFiltradosCategoria(String categoria) {
    final RepositoryDataBaseController repositoryController =Get.find<RepositoryDataBaseController>();


    //TODO ESPERAR TUDO CARREGAR AQUI TAMBEM
    var produtosFiltrados =  repositoryController.filtrarCategoria(categoria);

    // Exibir um indicador de carregamento enquanto os produtos estão sendo filtrados
    if (produtosFiltrados.isEmpty) {
      return LoadingWidget();
     } else {

      // Exibir a lista de produtos filtrados
      return Expanded(
        child: ListView.builder(
          itemCount: produtosFiltrados.length,
          itemBuilder: (context, index) {
            var produto = produtosFiltrados[index];
            return Card(
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoListTile(
                  onTap: () {
                    print('OPA!!!!'); // Ação do onTap
                  },
                  leading: CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.fastfood),
                  ),
                  title: CustomText(
                    text: '${produto.nome}', // Use os dados reais do produto
                    size: 20,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Preços: ${produto.precos}'),
                      CustomText(text: 'Ingredientes: ${produto.ingredientes?.join(', ')}'),
                      CustomText(
                        text:
                        'Preços: ${produto.precos.map((p) => p['preco']).join(' | ')}',
                        size: 16,
                        color: Colors.green,
                        weight: FontWeight.bold, // Exemplo de uso do preço
                      ),
                    ],
                  ),
                  trailing: BotaoFloatArredondado(icone: Icons.add_circle),
                ),
              ),
            );
          },
        ),
      );
    }

  }


  Widget BlurCardWidget(_child,size_h,size_w){


    return GlassContainer(
      height: size_h,
      width: size_w,
      gradient: LinearGradient(
        colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.lightBlueAccent.withOpacity(0.05), Colors.lightBlueAccent.withOpacity(0.6)],
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




  // Debug
  Widget buildListViewProdutosRepository() {
    final RepositoryDataBaseController repositoryController = Get.find<RepositoryDataBaseController>();

    return ListView.builder(
      itemCount: repositoryController.dataBase_Array
          .expand((x) => x)
          .length,
      itemBuilder: (context, index) {
        final produto = repositoryController.dataBase_Array.expand((x) => x).elementAt(
            index);
        return ListTile(
          title: Text(produto.nome),
          subtitle: Text('Categoria: ${produto.categoria}'),
        );
      },
    );
  }

  Widget _carregandoProdutos() {

    final RepositoryDataBaseController repositoryController = Get.find<RepositoryDataBaseController>();

    return FutureBuilder<List<List<ProdutoModel>>>(
      future: repositoryController.fetchAllProducts(),
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

                buildListViewProdutosRepository()
              ],
            ),
          );
        }
      },
    );
  }



}
