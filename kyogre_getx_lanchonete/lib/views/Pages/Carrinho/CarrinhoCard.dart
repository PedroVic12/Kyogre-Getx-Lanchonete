
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/BotoesIcone.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';

class CardCarrinho extends StatelessWidget {
  final int quantidade;
  final CarrinhoController carrinhoController;
  final Produto produto;

  CardCarrinho({Key? key, required this.produto, required this.quantidade, required this.carrinhoController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
        ),
        title: CustomText(text: produto.nome,),
        subtitle: CustomText(text: produto.preco!.preco1.toString(),),
        trailing: SizedBox(
          width: 120,  // You can adjust the width as needed
          child: Row(
            children: [
              BotoesIcone(
                onPressed: () {
                  carrinhoController.removerProduto(produto);
                },
                cor: Colors.black,
                iconData: CupertinoIcons.minus_circle_fill,
              ),
              CustomText(text: "$quantidade", size: 18),
              BotoesIcone(
                onPressed: () {
                  carrinhoController.adicionarProduto(produto);
                },
                cor: Colors.black,
                iconData: CupertinoIcons.plus_circle_fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
