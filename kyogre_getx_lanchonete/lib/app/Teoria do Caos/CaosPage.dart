import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/Teoria%20do%20Caos/MenuScrollLateral.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';

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
          JSONListView()

        ],
      )
    );
  }
}
