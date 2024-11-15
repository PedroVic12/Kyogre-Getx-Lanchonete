import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/MenuLateralNavegacao.dart';
import 'package:kyogre_getx_lanchonete/views/Screens/OverViewCards/OverViewCardLarge.dart';
import 'package:kyogre_getx_lanchonete/views/Screens/OverViewCards/OverViewCardSmall.dart';

class LargePage extends StatelessWidget {
  LargePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NightWolfAppBar(
          drawerKey: _drawerKey,
        ),
        drawer: Drawer(
          key: _drawerKey,
          // Adicione os itens do menu lateral aqui
          backgroundColor: CupertinoColors.systemYellow,
        ),
        body: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: MenuLateralNavegacaoDash()),
              Expanded(
                  flex: 4,
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    color: CupertinoColors.systemYellow,
                    child: OverViewCardsLarge(),
                  )),
            ],
          ),
        ));
  }
}

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: MenuLateralNavegacaoDash()),
        Expanded(
            flex: 4,
            child: Container(
              constraints: const BoxConstraints.expand(),
              color: CupertinoColors.activeOrange,
              child: OverViewCardsLarge(),
            )),
      ],
    );
  }
}

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.activeGreen,
      constraints: const BoxConstraints.expand(),
      child: const OverViewCardsSmallScreen(),
    );
  }
}
