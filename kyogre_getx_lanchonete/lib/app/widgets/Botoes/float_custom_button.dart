import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotaoFloatArredondado extends StatelessWidget {

  final IconData icone;

  const BotaoFloatArredondado({super.key, required this.icone});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      hoverColor: Colors.greenAccent,
      onPressed: (){},
      child: Icon(icone, size: 48, color: Colors.blueAccent,),
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
