import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotaoFloatArredondado extends StatelessWidget {

  final IconData icone;

  const BotaoFloatArredondado({super.key, required this.icone});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: (){},
      child: Icon(icone),
      elevation: 7.0,
      constraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 50
      ),
      shape: CircleBorder(),
      fillColor: Colors.indigo,
    );
  }
}
