import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/Teoria%20do%20Caos/MenuScrollLateral.dart';

class CaosPage extends StatefulWidget {
  const CaosPage({Key? key}) : super(key: key);

  @override
  State<CaosPage> createState() => _CaosPageState();
}

class _CaosPageState extends State<CaosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teoria do Caos'),
      ),
      body: Column(
        children: [
          Text('data'),
          CategoriasScoller(),
          MenuLateralScroll(),

        ],
      )
    );
  }
}
class CategoriasScoller extends StatelessWidget {
  const CategoriasScoller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.15;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: categoryHeight,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: List.generate(
            10,
                (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.green,
                child: Text('${index}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
