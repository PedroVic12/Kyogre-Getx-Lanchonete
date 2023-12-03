import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';

import '../../../models/DataBaseController/repository_db_controller.dart';

import '../Tela Cardapio Digital/controllers/pikachu_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController _controller = Get.put(SplashController());
    final CardapioController cardapioController = Get.put(CardapioController());

    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: GetBuilder<SplashController>(
        init: _controller,
        builder: (_) {
          return Stack(
            children: [
              AnimatedOpacity(
                opacity: _.isVisivel ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 5000),
                child: _buildLinhaDeIcones(),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 12000),
                onEnd: _controller.initSplashScreen,
                curve: Curves.fastLinearToSlowEaseIn,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: _controller.marginAnimada),
                child: Container(
                  width: 250,
                  height: 250,
                  child: Card(
                    color: Colors.indigo,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Image.asset(
                          'lib/repository/assets/citta_logo_light.png',
                          height: 200,
                          width: 200,
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildLinhaDeIcones() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIcone(Icons.access_time),
          CustomIcone(Icons.account_balance),
          CustomIcone(Icons.edit),
          CustomIcone(Icons.directions_bike),
          CustomIcone(Icons.settings),
          CustomIcone(Icons.wifi),
          CustomIcone(Icons.restaurant),
          buildSetupPage(),
          CustomIcone(Icons.directions_boat),
          CustomIcone(Icons.no_food),
          CustomIcone(Icons.table_restaurant_sharp),
        ],
      ),
    );
  }

  Widget CustomIcone(iconeData) {
    return Icon(
      iconeData,
      size: 48,
      color: Colors.white,
    );
  }

  Widget _buildAfterAnimation() {
    return Column(
      children: [
        Center(
          child: CustomText(
            text: 'Dados Carregados :) ',
            size: 32,
          ),
        ),
      ],
    );
  }

  Widget buildSetupPage() {
    final SplashController splashController = Get.put(SplashController());
    final CardapioController controller = Get.find<CardapioController>();

    return FutureBuilder(
      future: splashController.initSplashScreen(),
      builder: (context, snapshot) {
        // Caso os dados estejam carregados, mostra a mensagem por 2 segundos
        if (controller.menuCategorias.MenuCategorias_Array.isNotEmpty &&
            controller.repositoryController.dataBase_Array.isNotEmpty) {
          return _buildAfterAnimation();
        } else {
          // Caso contrário, mostra um widget de carregamento
          return LoadingWidget();
        }
      },
    );
  }
}

class SplashController extends GetxController {
  double marginAnimada = 0.0;
  bool isVisivel = false;
  var isLoadingData = false.obs;
  String id_cliente = '';

  final _productsLoader = Completer<void>();

  //controllers
  final MenuProdutosRepository menuCategorias =
      Get.put(MenuProdutosRepository());
  final RepositoryDataBaseController _repositoryController =
      Get.put(RepositoryDataBaseController());
  final CardapioController cardapioController = Get.put(CardapioController());

  @override
  void onReady() {
    isVisivel = true;
    marginAnimada = 240.0;

    initSplashScreen();

    update();
  }

  Future<void> initSplashScreen() async {
    // Carrega os dados
    await cardapioController.setupCardapioDigitalWeb();

    // Verifica se os dados estão carregados
    if (!cardapioController.isLoadingCardapio.value &&
        _repositoryController.dataBase_Array.isNotEmpty &&
        cardapioController.menuCategorias.MenuCategorias_Array.isNotEmpty) {
      // Atualiza a UI para mostrar "Dados Carregados"
      update();

      // Espera por 2 segundos
      await Future.delayed(Duration(seconds: 2));

      // Navega para a próxima tela
      navegarParaTelaCardapio();
      //verificarDadosCarregados();
    }
  }

  Future<void> verificarDadosCarregados() async {
    Timer(Duration(seconds: 3), () async {
      await navegarParaTelaCardapio();
    });
  }

  Future<void> navegarParaTelaCardapio() async {
    String id = '2077';
    Get.offNamed('/pedido/$id');
  }
}
