import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TelaCardapioDigitalWebPage extends StatelessWidget {
  const TelaCardapioDigitalWebPage({super.key});


  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Comportamento específico para a Web
      return Text('Visualizando em um navegador web');
    } else {
      // Comportamento para outras plataformas (móveis)
      return Text('Visualizando em um dispositivo móvel');
    }
  }
}