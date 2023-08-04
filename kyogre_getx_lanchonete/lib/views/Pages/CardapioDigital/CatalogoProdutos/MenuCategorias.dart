import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuCategorias extends StatefulWidget {
  final Function(int) onCategorySelected;

  MenuCategorias({Key? key, required this.onCategorySelected, required List<String> categorias}) : super(key: key);

  @override
  _MenuCategoriasState createState() => _MenuCategoriasState();
}

class _MenuCategoriasState extends State<MenuCategorias> {
  int selectedCategoryIndex = 0;

  List<String> categorias = [
    'Todos os Produtos',
    'Sanduíches Tradicionais',
    'Açaí e Pitaya',
    'Petiscos',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CupertinoColors.systemYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Categorias',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < categorias.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = i;
                        });
                        widget.onCategorySelected(i);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        height: 30,
                        decoration: BoxDecoration(
                          color: selectedCategoryIndex == i
                              ? Colors.red
                              : CupertinoColors.systemPurple,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.fastfood_rounded),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text(categorias[i]),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
