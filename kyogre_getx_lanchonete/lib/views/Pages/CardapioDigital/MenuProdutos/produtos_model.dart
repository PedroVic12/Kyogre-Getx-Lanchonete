import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/Custom/CustomText.dart';
import '../../../../models/DataBaseController/DataBaseController.dart';
import '../CatalogoProdutos/CatalogoProdutosController.dart';
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
      height: 50,
      width: 50,
      child: CircleAvatar(
        child: Icon(tipo, size: 24),
      ),
    );
  }
}


class CategoriaModel {
  String nome;
  Icon iconPath;
  Color boxColor;

  CategoriaModel(
      {required this.nome, required this.iconPath, required this.boxColor});
}

