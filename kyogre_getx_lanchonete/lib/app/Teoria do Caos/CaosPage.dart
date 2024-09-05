import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/DataBaseController.dart';

import '../../controllers/DataBaseController/template/produtos_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/Custom/CustomText.dart';

class LoadingController extends GetxController {
  RxInt segundos = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      segundos++;
      update();
    });
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoadingController());
    controller.segundos = 0.obs;

    return Center(
      child: Container(
        height: 120,
        width: 120,
        margin: const EdgeInsets.all(24),
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => CustomText(
                  text: 'Carregando... ${controller.segundos} s',
                  size: 12,
                  color: Colors.white,
                )),
            const CircularProgressIndicator(color: Colors.greenAccent),
            const Icon(
              Icons.cloud_upload_rounded,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Agora vamos usar o LoadingWidget no CaosPage

class CaosPage extends StatefulWidget {
  const CaosPage({Key? key}) : super(key: key);

  @override
  State<CaosPage> createState() => _CaosPageState();
}

class _CaosPageState extends State<CaosPage> {
  final DataBaseController _dataBaseController = DataBaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teoria do Caos'),
      ),
      body: FutureBuilder<List<Produto>>(
        future: _dataBaseController.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os produtos'),
            );
          } else if (snapshot.hasData) {
            List<Produto> produtos = snapshot.data!;
            return ListView(
              children: [
                ProdutosListView(
                    categoria: 'Sanduíches Tradicionais',
                    produtos: produtos
                        .where(
                            (p) => p.tipo_produto == 'Sanduíches Tradicionais')
                        .toList()),
                ProdutosListView(
                    categoria: 'Açaí e Pitaya',
                    produtos: produtos
                        .where((p) => p.tipo_produto == 'Açaí e Pitaya')
                        .toList()),
                ProdutosListView(
                    categoria: 'Petiscos',
                    produtos: produtos
                        .where((p) => p.tipo_produto == 'Petiscos')
                        .toList()),
              ],
            );
          } else {
            return const Center(
              child: Text('Não foi possível carregar os produtos'),
            );
          }
        },
      ),
    );
  }
}
