import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/template/produtos_model.dart';

class CarrouselImagensWidget extends StatelessWidget {
  final ProdutoModel produto_selecionado;
  CarrouselImagensWidget({super.key, required this.produto_selecionado});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    List<String>? imagens = produto_selecionado.imagem
        ?.split('|')
        .map((img) => 'lib/repository/assets/FOTOS/${img.trim()}')
        .toList();

    if (imagens == null || imagens.isEmpty) {
      // Se não houver imagens, exiba um widget padrão
      return Center(child: Text('Nenhuma imagem disponível'));
    }

    return CarouselView(
      itemExtent: screenSize.width - 80,
      itemSnapping: true,
      elevation: 7,
      padding: const EdgeInsets.all(8),
      backgroundColor: Colors.blueGrey.shade200,
      controller: CarouselController(
        initialItem: 0,
      ),
      children: imagens
          .map((img) => Image.asset(
                img,
                fit: BoxFit.cover,
              ))
          .toList(),
    );
  }
}
