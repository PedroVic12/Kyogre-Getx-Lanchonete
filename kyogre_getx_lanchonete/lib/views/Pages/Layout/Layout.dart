import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/SideMenu.dart';
import 'package:kyogre_getx_lanchonete/views/Screens/Screens.dart';
import 'package:kyogre_getx_lanchonete/views/responsividade/ResponsiveWidget.dart';



class Layout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: scaffoldKey,
        //TODO -> Menu Lateral de Navegação
        drawer: Drawer(
          child: SideMenu(),
        ),

        // Responsividade
        body: ResponsiveWidget(
            largeScreen: LargePage(),

            // tela Default
            smallScreen:
            //child: localNavigator(),
            SmallScreen()
        )
    );
  }
}


