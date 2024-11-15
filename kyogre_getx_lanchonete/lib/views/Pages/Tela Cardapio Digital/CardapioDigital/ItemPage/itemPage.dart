import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Barra%20Inferior/BarraInferior.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoController.dart';

class ItemPage extends StatelessWidget {
  final CarrinhoController controller = Get.find();

  ItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              padding: const EdgeInsets.all(15),
              height: 350,
              width: double.infinity,
              //decoration: BoxDecoration(             image: DecorationImage(image: AssetImage('imagens/2.png'))),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child:
                    const Icon(Icons.arrow_back, size: 30, color: Colors.green),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Titulo do Produto',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3))
                                    ]),
                                child: const Icon(CupertinoIcons.minus_circle),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: const Text('01',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3))
                                    ]),
                                child: const Icon(CupertinoIcons.plus_app),
                              ),
                            ],
                          )
                        ],
                      )),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Text('4.8 (230')
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text('Descrição:'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('This is the description od the product')
                      ],
                    ),
                  )
                ],
              ),
            ),
            //BarraInferiorWidget(totalCarrinho: controller.totalCarrinho)
          ],
        ),
      )),
    );
  }
}
