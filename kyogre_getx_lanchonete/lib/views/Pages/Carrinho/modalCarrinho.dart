import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatelessWidget {
  final CarrinhoController carrinhoController = Get.find<CarrinhoController>();
  final String nomeCliente;
  final String telefoneCliente;
  final String id;

  BottomSheetWidget({
    required this.nomeCliente,
    required this.telefoneCliente,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: DraggableScrollableSheet(
          builder: (context, scrollController) {
            return Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(Icons.add)),
                      title: Text('Carrinho'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          carrinhoController.setClienteDetails(
                              nomeCliente, telefoneCliente, id);
                          Get.to(CarrinhoPage(),
                              arguments: [nomeCliente, telefoneCliente, id]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Ver o Carrinho',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
