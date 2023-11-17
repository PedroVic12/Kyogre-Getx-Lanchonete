import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotaoFloatArredondado extends StatelessWidget {

  final IconData icone;

  const BotaoFloatArredondado({super.key, required this.icone});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      hoverColor: Colors.lightBlueAccent,
      onPressed: (){},
      child: Icon(icone, size: 48,),
      elevation: 25.0,
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: 100
      ),
      shape: CircleBorder(),
      fillColor: Colors.white,
      focusColor: Colors.blue,

    );
  }
}
