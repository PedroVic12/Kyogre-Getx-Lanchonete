
import 'package:flutter/material.dart';

class CategoriasWidget extends StatelessWidget {
  const CategoriasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categorias',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Text(
                'Ver todos',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var i = 0; i < 8; i++)
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6)
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.abc_sharp),
                        //child: Image.asset( '',  height: 50, width: 50,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Categoria:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}

