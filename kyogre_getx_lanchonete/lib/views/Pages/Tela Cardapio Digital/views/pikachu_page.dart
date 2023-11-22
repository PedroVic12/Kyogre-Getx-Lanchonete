import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pikachu_controller.dart';

class PikachuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PikachuController controller = Get.put(PikachuController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Pikachu Info'),
      ),
      body: FutureBuilder(
        future: controller.carregandoDados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() => controller.pikachuInfo.isNotEmpty
                ? Text('Pikachu: ${controller.pikachuInfo.value}')
                : Text('Nenhum dado de Pikachu disponível.'));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
