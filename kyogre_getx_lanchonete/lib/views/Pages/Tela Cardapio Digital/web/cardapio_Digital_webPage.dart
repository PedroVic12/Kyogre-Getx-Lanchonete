import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardapioDigtalApp extends StatefulWidget {
  const CardapioDigtalApp({super.key});

  @override
  State<CardapioDigtalApp> createState() => _CardapioDigtalAppState();
}

class _CardapioDigtalAppState extends State<CardapioDigtalApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cardapio QR Code.key Digital App"),
        ),
        body: const Center(
          child: Column(
            children: [
              Text('Visualizando em um dispositivo móvel'),
            ],
          ),
        ));
  }
}

class TelaCardapioDigitalWebPage extends StatelessWidget {
  const TelaCardapioDigitalWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Comportamento específico para a Web
      return const Text('Visualizando em um navegador web');
    } else {
      // Comportamento para outras plataformas (móveis)
      return const Text('Visualizando em um dispositivo móvel');
    }
  }
}
