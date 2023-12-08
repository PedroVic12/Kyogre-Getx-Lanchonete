import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../../../../models/DataBaseController/DataBaseController.dart';
import '../../CatalogoProdutos/CatalogoProdutosController.dart';
class ItemModel {
  final String label;

  ItemModel(this.label);
}

class IconePersonalizado extends StatelessWidget {
  IconData tipo;

  IconePersonalizado({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      child: CircleAvatar(
        child: Icon(tipo, size: 16),
      ),
    );
  }
}


class CategoriaModel {
  // Only `nome` is required
  final String nome;
  final Icon? iconPath; // Alterado para aceitar qualquer Widget
  final Image? img; // Marked as optional

  // Constructor accepts named arguments for all properties
  CategoriaModel({
    required this.nome,
    this.iconPath,
    this.img,
  });
}
