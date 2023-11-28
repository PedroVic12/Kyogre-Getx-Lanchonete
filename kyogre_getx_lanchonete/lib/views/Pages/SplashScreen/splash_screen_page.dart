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
                        //child: CircleAvatar(child: Icon(Icons.emoji_food_beverage_rounded,size: 48,)
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
          buildSetupPage(),
          CustomIcone(Icons.restaurant),
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
    final CardapioController cardapioController = Get.find<CardapioController>();

    return  Column(
      children: [
        Center(
          child: CustomText(
            text: 'Dados Carregados :) ',
            size: 48,
          ),
        ),


      ],
    );
  }

  Widget buildSetupPage() {
    final PikachuController controller = Get.put(PikachuController());
    final SplashController splashController = Get.put(SplashController());
    final RepositoryDataBaseController repository =   Get.find<RepositoryDataBaseController>();

    return FutureBuilder(
      future: splashController.initSplashScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(() => repository.dataBase_Array.isNotEmpty
              ? Column(
                  children: [
                    _buildAfterAnimation(),
                  ],
                )
              : const Text('Nenhum dado disponível. :('));
        } else {
          return const LoadingWidget();
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
  final MenuProdutosRepository menuCategorias = Get.put(MenuProdutosRepository());
  final RepositoryDataBaseController _repositoryController = Get.put(RepositoryDataBaseController());
  final CardapioController cardapioController = Get.put(CardapioController());

  @override
  void onReady() {
    isVisivel = true;
    marginAnimada = 240.0;

    initSplashScreen();

    update();

  }

  Future<void> initSplashScreen() async {
    await Future.delayed(const Duration(seconds: 5), () async {
      await cardapioController.setupCardapioDigitalWeb();
      verificarDadosCarregados();
    });
  }

  void verificarDadosCarregados() {
    if (!cardapioController.isLoadingCardapio.value &&
        _repositoryController.dataBase_Array.isNotEmpty ) {
      navegarParaTelaCardapio();
    }
  }

  void navegarParaTelaCardapio() async {
    String id = '2077';
    Get.offNamed('/pedido/$id');
  }
}
