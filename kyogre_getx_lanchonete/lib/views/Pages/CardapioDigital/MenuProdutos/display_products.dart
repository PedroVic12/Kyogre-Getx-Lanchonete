import 'package:flutter/material.dart';

class SelectedCategoryDisplay extends StatelessWidget {
  final List<String> nomesCategorias;
  final int selectedIndex;

  const SelectedCategoryDisplay({
    Key? key,
    required this.nomesCategorias,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PageView builder para percorrer os nomes das categorias
    return PageView.builder(
      itemCount: nomesCategorias.length,
      controller: PageController(initialPage: selectedIndex, viewportFraction: 1),
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            '${nomesCategorias[index]} - Índice: $index',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
