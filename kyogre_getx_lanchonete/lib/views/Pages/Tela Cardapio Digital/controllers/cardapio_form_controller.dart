
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';

class CardapioFormController extends GetxController {
  //! Formulário Ferramentas
  final nomeController = TextEditingController();
  final observacoesDique = TextEditingController();
  var nivelSelecionado = ''.obs;


  final CardapioController controller = Get.put(CardapioController());

  void setDados(){
   var ArrayPrecos = controller.repositoryController.dataBase_Array[3].precos;
   print(ArrayPrecos);
  }
  var niveis = <String>['Pequeno', 'Medio'].obs;
}


class CaixaDeTexto extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isReadOnly;
  final Function()? onTap;
  final double? height; // Adicione o parâmetro opcional

  CaixaDeTexto({
    required this.controller,
    required this.labelText,
    this.isReadOnly = false,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
          style: TextStyle(),
          controller: controller,
          readOnly: isReadOnly,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.purple[50],
            border: OutlineInputBorder(),
            label: Padding(
              padding:
              const EdgeInsets.only(left: 12.0), // Seu valor de padding
              child: Text(
                labelText,
                style: const TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: (height ?? 10.0), horizontal: 10.0),
          )),
    );
  }
}