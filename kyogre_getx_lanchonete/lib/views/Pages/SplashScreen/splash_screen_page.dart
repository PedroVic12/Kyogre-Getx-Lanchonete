import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/MenuProdutos/repository/MenuRepository.dart';

import '../../../models/DataBaseController/repository_db_controller.dart';
import '../../../models/DataBaseController/template/produtos_model.dart';
import '../Tela Cardapio Digital/controllers/pikachu_controller.dart';

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
                duration: const Duration(milliseconds: 3000),
                child: _buildLinhaDeIcones(),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 7000),
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
                        child: CircleAvatar(child: Icon(Icons.emoji_food_beverage_rounded,size: 48,)
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

    return Column(
      children: [
        CustomText(text: 'Dados Carregados', size: 32,)
      ],
    );
  }





  Widget buildSetupPage(){

    final PikachuController controller = Get.put(PikachuController());
    final SplashController splashController = Get.put(SplashController());
    final RepositoryDataBaseController repository = Get.find<RepositoryDataBaseController>();



    return FutureBuilder(
      //future: controller.carregarPaginaWeb(),
      future: splashController.carregandoDados(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {

          return Obx(() => repository.dataBase_Array.isNotEmpty
              ? Column(
            children: [
                    _buildAfterAnimation(),
                    Text('ARRAY = ${repository.dataBase_Array}'),
                    Text('Pikachu: ${controller.pikachuInfo.value}'),
            ],
          )
              : Text('Nenhum dado disponível.'));
        } else {
          return CircularProgressIndicator();
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
  final RepositoryDataBaseController _repositoryController =Get.put(RepositoryDataBaseController());
  final pikachu = PikachuController();

  @override
  void onReady() {
    super.onReady();
    isVisivel = true;
    marginAnimada = 250.0;
    carregandoDados();
    update();
  }




  void loadingData() async {
    //carregando
    await menuCategorias.getCategoriasRepository();
    await _repositoryController.loadData();
    update();

    pikachu.cout('Categorias = ${menuCategorias.MenuCategorias_Array}');
    pikachu.cout('Repository = ${_repositoryController.dataBase_Array}');

    //teste
    var products =  _repositoryController.filtrarCategoria('Pizzas');

    //debug
    pikachu.cout(products[0].categoria);
  }

  Future<void> carregandoDados() async {
    isLoadingData.value = true;
    try {
      loadingData();

      var array_db = _repositoryController.dataBase_Array;

      await Future.delayed(Duration(seconds: 2)); // Simulação de chamada de rede
      _productsLoader.complete(); // Complete o completer após o carregamento.

      // Simulando dados recebidos
      if(array_db.isNotEmpty){

        isLoadingData.value = false;

        Future.delayed(Duration(seconds: 1), () {
          //pikachu.loadDataSuccess('Repository Carregado com sucesso', '${array_db.length}');
        });

      }

    } catch (e) {
      print('\n\nErro ao carregar dados: $e');
    } finally {

      if(isLoadingData.value = false) {
        navegarParaTelaCardapio();
      }


    }
  }



  void navegarParaTelaCardapio() async {
    String id ='2023';
    Get.offNamed('/pedido/$id');
  }
}




















