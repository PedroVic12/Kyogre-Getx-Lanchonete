import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/responsividade/ResponsiveWidget.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
        color: Colors.purple,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 40),
                  Row(
                    children: [
                      SizedBox(
                        width: _width / 48,
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        //child: Image.asset('citta_logo.png'),),
                        child: Text('-> Logo da citta'),
                      ),
                      Flexible(
                          child: CustomText(
                        text: 'Teste de Drawer',
                        size: 20,
                        weight: FontWeight.bold,
                        color: CupertinoColors.activeOrange,
                      )),
                      SizedBox(
                        width: _width / 48,
                      ),
                      Divider(
                        color: CupertinoColors.systemGrey.withOpacity(.1),
                      ),
                      Column(
                        children: [
                          Text('SUA NAVEGAÇÃO AQUI CAPITAO JACKSPARROW')
                        ],
                      )
                    ],
                  )
                ],
              )
          ],
        ));
  }
}
