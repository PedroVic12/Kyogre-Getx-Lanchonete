//Controller
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class ProdutosDetails extends StatelessWidget {
  final String nome;
  final Icon imagem_produto;

  const ProdutosDetails({
    Key? key,
    required this.nome,
    required this.imagem_produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        CircleAvatar(child: imagem_produto),
        const SizedBox(height: 8),
        CustomText(
          text: nome,
          size: 14,
          weight: FontWeight.bold,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
