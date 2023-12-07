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
      child: Container(
        alignment: Alignment.center, // Certifica que o ícone fica centralizado no botão
        child: Icon(icone, size: 52, color: Colors.indigoAccent),
        width: 100,  // Define a largura do Container
        height: 100, // Define a altura do Container
      ),
      elevation: 32.0,
      constraints: BoxConstraints(
          maxHeight: 52,
          maxWidth: 52
      ),
      shape: CircleBorder(),
      fillColor: Colors.black,
      focusColor: Colors.green,
    );
  }
}
