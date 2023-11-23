import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Custom/CustomText.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding:  EdgeInsets.all(16),
            child: Container(
              height: 400,
              width: 400,
              margin:  EdgeInsets.all(24),
              color: Colors.blueGrey,
              child: Column(
                children: [
                  CustomText(text: 'Carregando...'), CircularProgressIndicator(),Icon(Icons.cloud_upload_rounded),

                  CustomText(text: 'Aguarde os produtos ficarem prontos.')
                ],
              ),
            ),
          )
      ),
    );
  }
}
