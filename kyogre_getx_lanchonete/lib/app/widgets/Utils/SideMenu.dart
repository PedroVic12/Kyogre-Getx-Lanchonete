import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/responsividade/ResponsiveWidget.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        color: Colors.purple,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 48,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(6),
                        //child: Image.asset('citta_logo.png'),),
                        child: Text('-> Logo da citta'),
                      ),
                      const Flexible(
                          child: CustomText(
                        text: 'Teste de Drawer',
                        size: 20,
                        weight: FontWeight.bold,
                        color: CupertinoColors.activeOrange,
                      )),
                      SizedBox(
                        width: width / 48,
                      ),
                      Divider(
                        color: CupertinoColors.systemGrey.withOpacity(.1),
                      ),
                      const Column(
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
