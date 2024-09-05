import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:convert';

import 'package:kyogre_getx_lanchonete/app/widgets/InfoCards/InfoCard.dart';

Future<dynamic> readJsonFile(String filePath) async {
  File file = File(filePath);
  if (await file.exists()) {
    String contents = await file.readAsString();
    dynamic jsonData = json.decode(contents);
    print("JSON data: $jsonData");
    return jsonData;
  } else {
    throw Exception('File not found: $filePath');
  }
}

Future<void> writeJsonFile(String filePath, dynamic data) async {
  File file = File(filePath);
  String jsonString = json.encode(data);
  await file.writeAsString(jsonString);
}

void updateJsonData() async {
  dynamic data = {
    'pedidosRecebidos': 10,
    'clientesAtivos': 5,
    'scheduledDeliveries': 40
  };
  await writeJsonFile('lib/repository/pedido_template.json', data);
}

class OverViewCardsLarge extends StatefulWidget {
  const OverViewCardsLarge({Key? key}) : super(key: key);

  @override
  State<OverViewCardsLarge> createState() => _OverViewCardsLargeState();
}

class _OverViewCardsLargeState extends State<OverViewCardsLarge> {
  final Map<String, int> cardData = {
    'pedidosRecebidos': 7,
    'clientesAtivos': 3,
    'scheduledDeliveries': 32,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth / 4;

          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: cardWidth / 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: cardWidth,
                      ),
                      InfoCard(
                        title: "Pedidos Recebidos",
                        value: cardData['pedidosRecebidos'].toString(),
                        onTap: () {},
                        isActive: true,
                      ),
                      SizedBox(width: cardWidth / 64),
                      InfoCard(
                        title: "Numero de clientes ativos",
                        value: cardData['clientesAtivos'].toString(),
                        onTap: () {},
                        isActive: true,
                      ),
                      SizedBox(width: cardWidth / 64),
                      InfoCard(
                        title: "Total de vendas",
                        value: cardData['scheduledDeliveries'].toString(),
                        onTap: () {},
                        isActive: true,
                      ),
                      SizedBox(width: cardWidth / 64),
                      Expanded(
                        child: Wrap(
                          spacing: cardWidth / 64,
                          runSpacing: cardWidth / 64,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
