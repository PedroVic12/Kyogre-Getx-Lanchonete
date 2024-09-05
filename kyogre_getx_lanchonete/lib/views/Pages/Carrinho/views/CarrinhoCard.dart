import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/BotoesIcone.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';

import '../../../../controllers/DataBaseController/template/produtos_model.dart';

class CardCarrinho extends StatelessWidget {
  final int quantidade;
  final CarrinhoPedidoController carrinhoController;
  final ProdutoModel produto;

  const CardCarrinho(
      {Key? key,
      required this.produto,
      required this.quantidade,
      required this.carrinhoController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? pathImg;
    if (produto.imagem != null) {
      List<String>? imagens = produto.imagem?.split('|');
      pathImg = 'lib/repository/assets/FOTOS/${imagens?[0].trim()}';
    }

    return Card(
      child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 32,
              child: pathImg != null
                  ? Image.network(
                      pathImg,
                    )
                  : const Icon(Icons.no_food)),
          title: CustomText(
            text: produto.nome,
            weight: FontWeight.bold,
          ),
          trailing: SizedBox(
            width: 130, // You can adjust the width as needed
            child: Row(
              children: [
                BotoesIcone(
                  onPressed: () {
                    carrinhoController.removerProduto(produto);
                  },
                  cor: Colors.black,
                  iconData: CupertinoIcons.minus_circle_fill,
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  text: "$quantidade",
                  size: 20,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 6,
                ),
                BotoesIcone(
                  onPressed: () {
                    carrinhoController.adicionarCarrinho(produto);
                  },
                  cor: Colors.black,
                  iconData: CupertinoIcons.plus_circle_fill,
                ),
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              produto.ingredientes != null
                  ? CustomText(
                      text: '${produto.ingredientes}',
                      size: 11,
                    )
                  : const Text(' '),
              const CustomText(text: 'Observações')
            ],
          ) //TODO
          ),
    );
  }
}
