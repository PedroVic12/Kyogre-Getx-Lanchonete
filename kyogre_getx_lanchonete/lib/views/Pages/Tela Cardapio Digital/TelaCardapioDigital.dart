import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomAppBar.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/Menu%20Tab/menu_tab_bar_widget.dart';
import '../../../app/widgets/Barra Inferior/BarraInferior.dart';
import '../../../controllers/DataBaseController/repository_db_controller.dart';
import 'web/cardapio_Digital_webPage.dart';
import 'controllers/pikachu_controller.dart';

class TelaCardapioDigital extends StatefulWidget {
  final String id;
  const TelaCardapioDigital({super.key, required this.id});

  @override
  State<TelaCardapioDigital> createState() => _TelaCardapioDigitalState();
}

class _TelaCardapioDigitalState extends State<TelaCardapioDigital> {
  final CardapioController controller = Get.put(CardapioController());
  final pikachu = PikachuController();
  final CarrinhoPedidoController carrinhoController =
      Get.put(CarrinhoPedidoController());

  @override
  void initState() {
    super.initState();
    controller.fetchClienteNome(widget.id);
    controller.setIdPage(widget.id);
    //controller.setupCardapioDigitalWeb();
    controller.initPage().then((value) => controller.setupCardapioDigitalWeb());
  }

  void showBarraInferior() {
    setState(() {
      controller.toggleBarraInferior();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Variaveis
    //repository
    List nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

    if (kIsWeb) {
      setState(() {});
      // Comportamento específico para a Web
      return buildWebPage();
    } else {
      // Comportamento para outras plataformas (móveis)
      return const CardapioDigtalApp();
    }
  }

  Widget buildWebPage() {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: CustomAppBar(id: widget.id),
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: controller.mostrarBarraInferior
                  ? 80
                  : 0, // Altura modificada pela variável
              child: ModalInferior(),
            )
          ],
        ),
      ),
      // floatingActionButton: Container(
      //   child: AnimatedFloatingActionButton(
      //     () => showBarraInferior(),
      //   ),
      //   height: 40,
      //   width: 40,
      // ),
    );
  }

  Widget _list() {
    return Obx(() {
      if (controller.repositoryController.dataBase_Array.isEmpty) {
        return const Center(child: LoadingWidget());
      } else {
        return ListView.builder(
          itemCount: controller.repositoryController.dataBase_Array.length,
          itemBuilder: (context, index) {
            var produto = controller.repositoryController.dataBase_Array[index];
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
            return const LoadingWidget();
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
                    CustomText(text: 'Precos: ${item.preco_1}')
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
        const Text('Visualizando em uma pagina WEB'),
        const Text('Dados do Cliente: '),
        Text('ID do Pedido: ${controller.idPedido}'),
        Text('Nome do Cliente: ${controller.nomeCliente}'),
        Text('Telefone do Cliente: ${controller.telefoneCliente}'),
      ],
    );
  }
}
