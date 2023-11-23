import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/themes%20/cores.dart';

import '../Custom/CustomText.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.all(16),
        child: Center(child:  Container(
          height: 200,
          width: 200,
          margin:  EdgeInsets.all(24),
          color: azul,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(text: 'Carregando...',size: 18,color: Colors.white,), CircularProgressIndicator(color: Colors.greenAccent),Icon(Icons.cloud_upload_rounded,color: Colors.white,),

            ],
          ),
        ),)
    );
  }
}
