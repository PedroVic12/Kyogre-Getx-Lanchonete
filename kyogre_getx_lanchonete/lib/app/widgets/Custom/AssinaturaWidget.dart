import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/BotaoPadrao.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class AssinaturaWidget extends StatelessWidget {
  AssinaturaWidget({super.key});

  final GlobalKey<SfSignaturePadState> _assinaturaKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        width: 400,
        child: Column(
          children: [
            SfSignaturePad(
              key: _assinaturaKey,
              backgroundColor: Colors.grey.shade300,
              strokeColor: Colors.white,
              minimumStrokeWidth: 4.0,
              maximumStrokeWidth: 6.0,
            ),
            Row(
              children: [
                BotaoPadrao(
                    color: Colors.red,
                    on_pressed: () {
                      _assinaturaKey.currentState!.clear();
                    },
                    child: const CustomText(
                      text: "Clear",
                    )),
                BotaoPadrao(
                    color: Colors.blue,
                    on_pressed: () {},
                    child: const CustomText(
                      text: "Salvar assinatura",
                    ))
              ],
            )
          ],
        ));
  }
}
