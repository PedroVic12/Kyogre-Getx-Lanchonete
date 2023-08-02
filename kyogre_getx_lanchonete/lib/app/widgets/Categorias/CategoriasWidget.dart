import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:flutter/cupertino.dart';
class CategoriasWidget extends StatefulWidget {
  final Color backgroundColor;
  final DataBaseController dataBaseController;

  const CategoriasWidget({
    Key? key,
    required this.backgroundColor,
    required this.dataBaseController,
  }) : super(key: key);

  @override
  _CategoriasWidgetState createState() => _CategoriasWidgetState();
}

class _CategoriasWidgetState extends State<CategoriasWidget> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lanchonete App'),
      ),
      body: Card(
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CategoriasHeader(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CategoriasList(dataBaseController: widget.dataBaseController),
            ),
            SizedBox(height: 10),
            Expanded(
              child: CategoriasListView(dataBaseController: widget.dataBaseController),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriasHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ],
      ),
    );
  }
}

class CategoriasList extends StatefulWidget {
  final DataBaseController dataBaseController;

  CategoriasList({required this.dataBaseController});

  @override
  _CategoriasListState createState() => _CategoriasListState();
}

class _CategoriasListState extends State<CategoriasList> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < widget.dataBaseController.categoriasLength; i++)
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
                color: selectedCategoryIndex == i
                    ? Colors.red // Cor do fundo do item selecionado
                    : Colors.blueGrey, // Cor do fundo padrão
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
                    //child: Image.asset('', height: 50, width: 50,),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${widget.dataBaseController.categorias.keys.toList()[i]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class CategoriasListView extends StatefulWidget {
  final DataBaseController dataBaseController;

  CategoriasListView({required this.dataBaseController});

  @override
  _CategoriasListViewState createState() => _CategoriasListViewState();
}

class _CategoriasListViewState extends State<CategoriasListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dataBaseController.categoriasLength,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("${widget.dataBaseController.categorias.keys.toList()[index]}"),
        );
      },
    );
  }
}