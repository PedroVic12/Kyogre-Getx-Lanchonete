import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/app/widgets/Botoes/animated_float_button.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomAppBar.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/Menu%20Tab/menu_tab_bar_widget.dart';
import '../../../app/widgets/Barra Inferior/BarraInferior.dart';
import '../../../controllers/DataBaseController/repository_db_controller.dart';
import '../Carrinho/CarrinhoController.dart';
import 'controllers/pikachu_controller.dart';

class CardapioQrCode extends StatefulWidget {
  const CardapioQrCode({super.key});

  @override
  State<CardapioQrCode> createState() => _CardapioQrCodeState();
}

class _CardapioQrCodeState extends State<CardapioQrCode> {
  final CardapioController controller = Get.put(CardapioController());
  final pikachu = PikachuController();
  final CarrinhoPedidoController carrinhoController =
      Get.put(CarrinhoPedidoController());

  @override
  void initState() {
    super.initState();
    controller.setupCardapioDigitalWeb();
    //controller.initPage().then((value) =>  controller.setupCardapioDigitalWeb());
  }

  void showBarraInferior() {
    setState(() {
      controller.toggleBarraInferior();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Variaveis
    List nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Column(
          children: [
            CustomText(
                text: 'Citta RJ ${nomesLojas[0]}',
                color: Colors.white,
                size: 20)
          ],
        ),
        backgroundColor: CupertinoColors.black,
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 7.0,
        toolbarHeight: 72,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(128))),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            //pegarDadosCliente(),
            Expanded(
              child: GetBuilder<CardapioController>(
                builder: (controller) {
                  return const MenuTabBarCardapio();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
