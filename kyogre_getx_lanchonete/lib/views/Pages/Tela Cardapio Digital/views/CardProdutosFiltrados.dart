import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_controller.dart';

import '../../../../app/widgets/Botoes/float_custom_button.dart';
import '../../../../app/widgets/Custom/CustomText.dart';
import '../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../models/DataBaseController/template/produtos_model.dart';
import '../../Carrinho/CarrinhoController.dart';

class CardProdutosFiltrados extends StatelessWidget {
  const CardProdutosFiltrados({super.key});

  @override
  Widget build(BuildContext context) {


    final MenuProdutosController menuController = Get.find<MenuProdutosController>();
    final RepositoryDataBaseController _repositoryController = Get.find<RepositoryDataBaseController>();
    final CarrinhoController carrinhoController = Get.put(CarrinhoController());

    var categorias = menuController.categoriasProdutosMenu[menuController.produtoIndex.value];

    //var produtos = _repositoryController.filtrarCategoria(categorias as String);


    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [

          _headerProdutos(),

          // Card content
      CupertinoListTile(
          title: CustomText(
            text: "produto.nome",
            size: 20,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: 'Precos')
              // text:'Preços: ${produto.precos.map((p) => p['preco']).join(', ')}', size: 16,color: Colors.green,weight: FontWeight.bold,),
            ],
          ),
          leading: CircleAvatar(radius: 32, child: Icon(Icons.fastfood),),
          trailing: BotaoFloatArredondado(icone: Icons.add_circle,)
      )

        ],
      ),
    );
  }

  Widget displayProdutos(int index) {
    final menuController = Get.find<MenuProdutosController>();
    var produto = menuController.categoriasProdutosMenu[index];

    return Center(
      child: Text(
        'Produto: ${produto.nome}',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }


  Widget displayProdutosFiltradosCategoria(String categoria) {
    final RepositoryDataBaseController _repositoryController = Get.find<RepositoryDataBaseController>();

    return FutureBuilder<List<ProdutoModel>>(
      future: _repositoryController.filtrarCategoria(categoria),
      builder: (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var produto = snapshot.data![index];
              return ListTile(
                title: Text(produto.nome),
                subtitle: Text('Ingredientes: ${produto.ingredientes?.join(', ')}'),
                trailing: Text('Preços: ${produto.precos.map((p) => p['preco']).join(', ')}'),
              );
            },
          );
        } else {
          return Text('Nenhum dado disponível');
        }
      },
    );
  }


  Widget _headerProdutos(){
    return    // Header
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),

            CustomText(text: 'Categoria selecionada = '),
            Divider(height: 10, color: Colors.grey,),

          ],
        ),
      );
  }

}
