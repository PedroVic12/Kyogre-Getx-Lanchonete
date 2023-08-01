import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';

import '../../../models/DataBaseController/Produtos/Produto.dart';

class CategoriasWidget extends StatefulWidget {
  final Color backgroundColor;

  const CategoriasWidget({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _CategoriasWidgetState createState() => _CategoriasWidgetState();
}

class _CategoriasWidgetState extends State<CategoriasWidget> {
  int selectedCategoryIndex = 0;
  final DataBaseController _dataBaseController = DataBaseController();
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    // _loadProdutos('bebidas.json');
    // _loadProdutos('sobremesas.json');
  }


  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Citta Lanchonete {local}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
                /*
                * Text(
                  'Ver todos',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
                * */

              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < 8; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = i;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: i == selectedCategoryIndex
                            ? Colors.red // Cor do fundo do item selecionado
                            : widget.backgroundColor, // Cor do fundo padrão
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.abc_sharp),
                            //child: Image.asset('', height: 50, width: 50,),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Categoria $i',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
