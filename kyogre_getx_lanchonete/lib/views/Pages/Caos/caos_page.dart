import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/DataBaseController/Views/repositoryView.dart';

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
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [


            ElevatedButton(onPressed: (){
              Get.to(RepositoryListView());
            }, child: Text('produdutos')),



            ElevatedButton(
                onPressed: () {
                  //Get.to(MenuCardapioScollPage());
                },
                child: Text('Menu Page View')),

          ],
        ),
      )
    );
  }
}
