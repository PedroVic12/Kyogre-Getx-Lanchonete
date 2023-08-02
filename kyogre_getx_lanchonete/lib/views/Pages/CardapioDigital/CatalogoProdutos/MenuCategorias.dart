import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class MenuCategorias extends StatefulWidget {
  MenuCategorias({Key? key}) : super(key: key);

  @override
  _MenuCategoriasState createState() => _MenuCategoriasState();
}

class _MenuCategoriasState extends State<MenuCategorias> {
  int selectedCategoryIndex = 0;

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
              child: CustomText(
                text: 'Categorias',
                size: 25,
                weight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 1; i < 8; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = i;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedCategoryIndex == i
                              ? Colors.red // Cor do fundo do item selecionado
                              : CupertinoColors.systemPurple, // Cor do fundo padrão
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
                              child: CustomText(
                                text: 'Categoria $i',
                              ),
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