import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

import '../template/produtos_model.dart';

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