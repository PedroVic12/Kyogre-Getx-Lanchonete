import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class CustomCard extends StatelessWidget {
  final Color cor_icone;
  final Color cor_card;
  final IconData tipoIcone;
  final String texto_card;
  final Widget? child; // Opcional: O parâmetro child agora é um Widget opcional

  CustomCard({
    Key? key,
    required this.cor_icone,
    required this.cor_card,
    required this.tipoIcone,
    required this.texto_card,
    this.child, // Opcional: O parâmetro child agora é opcional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cor_card,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Define o raio dos cantos
        ),
      child: ListTile(
        leading: Icon(
          tipoIcone,
          size: 25,
          color: cor_icone,
        ),

        title: CustomText(
          text: texto_card,
          size: 18,
        ),
      )
    );
  }
}
