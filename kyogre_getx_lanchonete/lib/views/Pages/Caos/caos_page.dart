import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaosPageWidget extends StatefulWidget {
  const CaosPageWidget({super.key});

  @override
  State<CaosPageWidget> createState() => _CaosPageWidgetState();
}

class _CaosPageWidgetState extends State<CaosPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Caos page'),),
      body: Column(
        children: [


          ElevatedButton(
              onPressed: () {
                //Get.to(MenuCardapioScollPage());
              },
              child: Text('Menu Page View')),

        ],
      ),
    );
  }
}
