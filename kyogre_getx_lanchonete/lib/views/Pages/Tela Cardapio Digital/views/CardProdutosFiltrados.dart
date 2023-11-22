import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    // Certifique-se de que repositoryController.dataBase_Array contém os dados desejados
    var produtos = repositoryController.dataBase_Array;

    return Container(
      color: Colors.blueGrey.shade700,
      child: Column(
        children: [
          _headerProdutos(categoria_selecionada),

          displayProdutosFiltradosCategoria(categoria_selecionada)
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
          Icon(CupertinoIcons.search, color: Colors.white),
          SizedBox(width: 16,),
          CustomText(
            text: 'Item selecionado = ${menuCategorias.MenuCategorias_Array[menuController.produtoIndex.value].nome}',
            color: Colors.white,
            size: 18,
          ),
          Divider(height: 10, color: Colors.grey),
        ],
      ),
    );
  }


  Widget displayProdutosFiltradosCategoria(String categoria) {
    final RepositoryDataBaseController repositoryController = Get.find<RepositoryDataBaseController>();

    if (repositoryController.produtosFiltrados.isEmpty) {
      return   Card(
        child: Column(children: [
          CustomText(text: 'Carregando...'),
          CircularProgressIndicator()
        ],),
      );
     } else {
      return  Expanded(child: ListView.builder(

        //itemCount: 10,
        itemCount: repositoryController.produtosFiltrados.length,
        itemBuilder: (context, index) {
          var produto = repositoryController.produtosFiltrados[index];
          return Card(
            margin: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoListTile(
                onTap: () {
                  print('OPA!!!!'); // Ação do onTap
                },
                title: CustomText(
                  text: '${produto.nome}', // Use os dados reais do produto
                  size: 20,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'Preços: ${produto.precos}'),
                    CustomText(text: 'Ingredientes: ${produto.ingredientes?.join(', ')}'),
                    CustomText(text:'Preços: ${produto.precos.map((p) => p['preco']).join(' | ')}', size: 16,color: Colors.green,weight: FontWeight.bold,),// Exemplo de uso do preço
                  ],
                ),
                leading: CircleAvatar(
                  radius: 32,
                  child: Icon(Icons.fastfood),
                ),
                trailing: BotaoFloatArredondado(icone: Icons.add_circle),
              ),
            )
          );
        },
      ));
    }
  }

}
