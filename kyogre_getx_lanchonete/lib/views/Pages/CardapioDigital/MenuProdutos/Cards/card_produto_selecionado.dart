
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../../../../models/DataBaseController/repository_db_controller.dart';
import '../../../../../models/DataBaseController/template/produtos_model.dart';
import '../../../Carrinho/CarrinhoController.dart';

class CardProdutoCardapioSelecionado extends StatelessWidget {
  final String produtoSelecionado;

  const CardProdutoCardapioSelecionado({super.key, required this.produtoSelecionado});


  @override
  Widget build(BuildContext context) {
    return Card(
      child: CupertinoListTile(
          title: Column(
            children: [
              CustomText(text: 'Exibindo: $produtoSelecionado',),
              displayProdutosFiltradosCategoria(produtoSelecionado),
            ],
          )
      ),
    );
  }

  Widget displayProdutosFiltradosCategoria(String categoria) {
    final RepositoryDataBaseController _repositoryController = Get.find<RepositoryDataBaseController>();
    final CarrinhoController carrinhoController = Get.put(CarrinhoController());

    return FutureBuilder<List<ProdutoModel>>(
      future: _repositoryController.filtrarCategoria(categoria),
      builder: (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (snapshot.hasData) {

          return Container(
            color: Colors.grey,
            height: 400,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var produto = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: CupertinoListTile(
                    title: CustomText(
                      text: produto.nome,
                      size: 20,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text:'Preços: ${produto.precos.map((p) => p['preco']).join(', ')}', size: 16,color: Colors.green,weight: FontWeight.bold,),
                      ],
                    ),
                    leading: CircleAvatar(radius: 32,child: Icon(Icons.fastfood),),
                    trailing: IconButton(
                      icon: Icon( Icons.add_box_sharp, color: Colors.blue, size: 48), // Um botão para adicionar o produto ao carrinho
                      onPressed: () {
                        carrinhoController
                            .adicionarProduto(
                            produto as Produto);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Text('Nenhum dado disponível');
        }
      },
    );
  }
}






class ProdutosListWidget extends StatelessWidget {
  final List<ProdutoModel> produtos;

  const ProdutosListWidget({Key? key, required this.produtos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        var produto = produtos[index];
        return Card(
          child: CupertinoListTile(
            padding: EdgeInsets.all(12.0),
            leading: Icon(Icons.no_food_rounded), // Ou Image.network(produto.imagem!)
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Categoria: ${produto.categoria}', size: 16, weight: FontWeight.bold),
                CustomText(text: produto.nome, size: 18, weight: FontWeight.bold),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0, // Espaço entre os preços
                  children: produto.precos.map((p) => Text('Preço ${p['descricao']}: ${p['preco']}')).toList(),
                ),
                if (produto.ingredientes != null)
                  Text('Ingredientes: ${produto.ingredientes!.join(', ')}'),
              ],
            ),
            trailing: CircleAvatar(
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.add),
              ),
            ),
          ),
        );
      },
    );
  }
}
