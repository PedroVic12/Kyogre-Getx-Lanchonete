import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';

import '../../../../app/widgets/Botoes/float_custom_button.dart';
import '../../../../app/widgets/Custom/CustomText.dart';
import '../../../../models/DataBaseController/repository_db_controller.dart';
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

    var produtos = repositoryController.dataBase_Array;
    var nome_categoria_selecionada = menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome;
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.blueGrey.shade700,
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(height: 10, color: Colors.grey),
          Icon(CupertinoIcons.search, color: Colors.white),
          SizedBox(width: 16,),
          CustomText(
            text: 'Item selecionado = ${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome}',
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget displayProdutosFiltradosCategoria(String categoria) {
    final RepositoryDataBaseController repositoryController =Get.find<RepositoryDataBaseController>();


    //TODO ESPERAR TUDO CARREGAR AQUI TAMBEM



    var produtosFiltrados =  repositoryController.filtrarCategoria(categoria);


      print('DEBUB = ${produtosFiltrados[2].categoria}');


    // Exibir um indicador de carregamento enquanto os produtos estão sendo filtrados
    if (produtosFiltrados.isEmpty) {
      return Card(
        child: Column(
          children: [CustomText(text: 'Carregando...'), CircularProgressIndicator()],
        ),
      );
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



}
