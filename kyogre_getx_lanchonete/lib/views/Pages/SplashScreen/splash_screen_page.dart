import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';

import '../../../models/DataBaseController/repository_db_controller.dart';
import '../CardapioDigital/MenuProdutos/produtos_controller.dart';
import '../Tela Cardapio Digital/TelaCardapioDigital.dart';
import '../Tela Cardapio Digital/controllers/cardapio_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController _controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) {
          return Stack(
            children: [
              AnimatedOpacity(
                opacity: _.isVisivel ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1500),
                child: _buildLinhaDeIcones(),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                onEnd: _controller.navegarParaTelaCardapio,
                curve: Curves.fastLinearToSlowEaseIn,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: _controller.marginAnimada),
                child: Container(
                  width: 220,
                  height: 220,
                  child: Card(
                    color: Colors.indigo,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(child: Icon(Icons.emoji_food_beverage_rounded,size: 36,)
                            // Image.asset(
                            //   'lib/repository/assets/citta_logo_light.png',
                            //   height: 400,
                            //   width: 400,
                            //   alignment: Alignment.center,
                            //   fit: BoxFit.fitHeight,
                            // ),
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
          CustomIcone(Icons.settings),
          CustomIcone(Icons.account_balance),
          CustomIcone(Icons.edit),
          CustomIcone(Icons.directions_bike),
          CustomIcone(Icons.directions_boat),
          CustomIcone(Icons.wifi),
          CustomIcone(Icons.restaurant),
          CustomIcone(Icons.table_restaurant_sharp),
          CustomIcone(Icons.adb_rounded),
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
    return Text(
      'OLA MUNDO',
      style: TextStyle(fontSize: 32),
    );
  }
}

class SplashController extends GetxController {
  double marginAnimada = 0.0;
  bool isVisivel = false;
  bool dadosCarregados = false;
  String id_cliente = '';

  final _productsLoader = Completer<void>();

  //controllers
  final MenuProdutosController menuController =Get.put(MenuProdutosController());
  final MenuProdutosRepository menuCategorias = Get.put(MenuProdutosRepository());
  final RepositoryDataBaseController _repositoryController =Get.put(RepositoryDataBaseController());


  @override
  void onReady() {
    super.onReady();
    isVisivel = true;
    marginAnimada = 250.0;
    carregarDadosDoCardapio();
    update();
  }

  Future<void> carregarDadosDoCardapio() async {

    await menuCategorias.getCategoriasRepository();
    await _repositoryController.loadData();

    await Future.delayed(const Duration(seconds: 3));
    _productsLoader.complete(); // Complete o completer após o carregamento.

    if (menuCategorias.isLoading.value){
      navegarParaTelaCardapio();
    }
  }

  void navegarParaTelaCardapio() async {
    String id ='2023';
    Get.offNamed('/pedido/$id');
  }
}
