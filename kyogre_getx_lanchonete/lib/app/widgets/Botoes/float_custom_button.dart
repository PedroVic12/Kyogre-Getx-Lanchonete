import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotaoFloatArredondado extends StatelessWidget {

  final IconData icone;
  final VoidCallback onPress;

  const BotaoFloatArredondado({super.key, required this.icone, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      hoverColor: Colors.greenAccent,
      onPressed: onPress,
      child: Icon(icone, size: 48, color: Colors.indigoAccent,),
      elevation: 25.0,
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: 100
      ),
      shape: CircleBorder(),
      fillColor: Colors.black,
      //focusColor: Colors.blue,

    );
  }
}
