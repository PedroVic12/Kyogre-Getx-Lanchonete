import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/database/controllers/MongoDBServices/mongo_service.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../controllers/cardapio_manager.dart';
import '../../controllers/cardapio_repository.dart';

class CardapioManagerPage extends StatelessWidget {
  final manager = CardapioManager();
  final repository = CardapioRepository();
  final mongoServiceDB = Get.put(MongoServiceDB());
  void initPage() async {
    await mongoServiceDB.getProducts();
  }

  // separar o collection e categoria
  // cada produto com adicional ser tratado diferente

  @override
  Widget build(BuildContext context) {
    initPage();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CARDAPIO DIGITAL DE {RUBY}'),
      ),
      body: Column(
        children: [
          TextButton(onPressed: () {}, child: const Text("Procurar Produto")),
          Container(
            height: 500, // Defina a altura da lista horizontal
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Lista na direção horizontal
              itemCount: repository.categoriasCardapio.length,
              itemBuilder: (context, index) {
                var produtoCardapio = repository.arrayProdutos[index];
                var categoriasCardapio = repository.categoriasCardapio[index];
                return Container(
                  width: 250, // Largura de cada contêiner
                  margin: const EdgeInsets.all(
                      12), // Espaçamento ao redor de cada contêiner
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? Colors.blue
                        : Colors.green, // Cores alternadas para os contêineres
                    borderRadius:
                        BorderRadius.circular(10), // Borda arredondada
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      botoesSuperior(context, categoriasCardapio),
                      Card(
                        elevation: 5, // Elevação do card
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                leading:
                                    const CircleAvatar(child: Placeholder()),
                                title: Text(
                                  '${produtoCardapio["NOME"]}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          "R\$ ${produtoCardapio["PRECO"].toString()} reais"),
                                    ]),
                                trailing: CircleAvatar(
                                  child: PopupMenuButton(
                                      itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              value: "Editar Produto",
                                              child: Text("Editar Produto"),
                                            ),
                                            const PopupMenuItem(
                                              child: Text("Deletar Produto"),
                                              value: "Deletar Produto",
                                            ),
                                          ],
                                      onSelected: (String newValue) {}),
                                ))),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          showMongo()
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            manager.criarCategoria();
          },
          tooltip: 'Criar Categoria',
          child: const Text('Criar Categoria')), //
    );
  }

  Widget showMongo() {
    return Container(
      color: Colors.white,
      child: GetBuilder<MongoServiceDB>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.productsMongo.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          } else {
            // Se houver produtos, exibe-os usando ListView.builder
            return ListView.builder(
              itemCount: controller.productsMongo.length,
              itemBuilder: (context, index) {
                var product = controller.productsMongo[index];

                return Card(
                  child: ListTile(
                    title: Text(product["NOME"]),
                    subtitle: Text(product["preco_1"].toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          controller.deleteProduct(product["NOME"]),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget botoesSuperior(BuildContext context, produto) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withBlue(10),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              print("Deletar Categoria");
              manager.showAlertDialog(context, produto);
            },
            child: const Icon(
              CupertinoIcons.minus_circle_fill,
              color: Colors.white,
              size: 24,
            ),
          ),
          CustomText(
            text: produto,
            color: Colors.white,
            size: 18,
          ),
          InkWell(
            onTap: () {
              manager.showCadastroDialog(context, produto);
            },
            child: const Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
