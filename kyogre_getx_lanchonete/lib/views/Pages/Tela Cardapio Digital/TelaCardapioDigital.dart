import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomAppBar.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/Menu%20Tab/menu_tab_bar_widget.dart';
import '../../../app/widgets/Barra Inferior/BarraInferior.dart';
import '../../../models/DataBaseController/repository_db_controller.dart';
import '../Carrinho/CarrinhoController.dart';
import 'cardapio_Digital_webPage.dart';
import 'controllers/pikachu_controller.dart';

/*
* Paleta de Cores : #ff8c00 , #f2ff00, # ff0d00
*
* page_turn
* glass_kit
* */

class TelaCardapioDigital extends StatefulWidget {
  final String id;
  const TelaCardapioDigital({super.key, required this.id});

  @override
  State<TelaCardapioDigital> createState() => _TelaCardapioDigitalState();
}

class _TelaCardapioDigitalState extends State<TelaCardapioDigital> {

  final CardapioController controller = Get.put(CardapioController());
  final pikachu = PikachuController();
  final CarrinhoPedidoController carrinhoController = Get.put(CarrinhoPedidoController());




  @override
  void initState() {
    super.initState();
    controller.fetchClienteNome(widget.id);
    controller.initPage();
  }


  bool mostrarBarraInferior = false;

  void toggleBarraInferior() {
    setState(() {
      mostrarBarraInferior = !mostrarBarraInferior;
    });
  }


  @override
  Widget build(BuildContext context) {



    // Variaveis
    List nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

    if (kIsWeb) {
      setState(() {

    });
      // Comportamento específico para a Web
      return buildWebPage();

    } else {
      // Comportamento para outras plataformas (móveis)
      return CardapioDigtalApp();
    }
  }

  Widget buildWebPage() {


    return Scaffold(
      backgroundColor: Colors.red,
      appBar: CustomAppBar(id: widget.id),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(child: GetBuilder<CardapioController>(
              builder: (controller) {
                return const MenuTabBarCardapio();
              },
            ),),

              AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: mostrarBarraInferior ? 80 : 0,  // Altura modificada pela variável
              child: ModalInferior(),
              )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          toggleBarraInferior();
        },
      ),
    );


  }


  Widget _list() {

    return Obx(() {
      if (controller.repositoryController.dataBase_Array.isEmpty) {
        return Center(child: LoadingWidget());
      } else {
        return ListView.builder(
          itemCount: controller.repositoryController.dataBase_Array.length,
          itemBuilder: (context, index) {
            var produto =controller.repositoryController.dataBase_Array[index];
            return ListTile(
              title: Text(produto.nome),
              subtitle: Text('Categoria: ${produto.categoria}'),
            );
          },
        );
      }
    });
  }

  Widget buildListRepository() {
    final RepositoryDataBaseController repositoryController =
    Get.find<RepositoryDataBaseController>();

    return Container(
        color: Colors.white,
        height: 300,
        child: Obx(() {
          if (repositoryController.dataBase_Array.isEmpty) {
            return LoadingWidget();
          } else {
            setState(() {});
            return ListView.builder(
              itemCount: repositoryController.dataBase_Array.length,
              itemBuilder: (context, index) {
                var item = repositoryController.dataBase_Array[index];
                return ListTile(
                    subtitle: Column(
                      children: [
                        CustomText(
                          text: '\n\nProduto: ${item.nome}',
                        ),
                        CustomText(text: 'Categoria: ${item.categoria}'),
                        CustomText(text: 'Precos: ${item.precos}')
                      ],
                    ));
              },
            );
          }
        }));
  }




  Widget pegarDadosCliente() {
    return Column(
      children: [
        Text('Visualizando em uma pagina WEB'),
        const Text('Dados do Cliente: '),
        Text('ID do Pedido: ${controller.idPedido}'),
        Text('Nome do Cliente: ${controller.nomeCliente}'),
        Text('Telefone do Cliente: ${controller.telefoneCliente}'),
      ],
    );
  }
}







