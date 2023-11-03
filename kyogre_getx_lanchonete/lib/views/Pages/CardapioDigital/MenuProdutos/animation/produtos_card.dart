import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/produtos_model.dart';

class ProdutoDetalhesView extends StatelessWidget {
  final PageController pageController;
  final RxInt produtoSelecionadoIndex;
  final List<CategoriaModel> produtos;

  ProdutoDetalhesView({
    Key? key,
    required this.pageController,
    required this.produtoSelecionadoIndex,
    required this.produtos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: produtos.length,
      onPageChanged: (index) {
        produtoSelecionadoIndex.value = index; // Atualiza o índice do item selecionado.
      },
      itemBuilder: (context, index) {
        // Este é o seu ProdutoModel que deve ter um nome e talvez uma imagem ou outras propriedades.
        CategoriaModel produto = produtos[index];

        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Produto Selecionado',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 20),
              Text(
                produto.nome, // O nome do produto selecionado.
                style: Theme.of(context).textTheme.headline6,
              ),
              // Aqui, você pode adicionar mais detalhes sobre o produto, como uma imagem ou descrição.
            ],
          ),
        );
      },
    );
  }
}
