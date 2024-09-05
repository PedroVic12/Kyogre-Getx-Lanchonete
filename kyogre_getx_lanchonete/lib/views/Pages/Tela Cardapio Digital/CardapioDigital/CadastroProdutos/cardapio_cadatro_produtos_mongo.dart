import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/database/controllers/MongoDBServices/mongo_service.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CadastroProdutos/widgets/cadastro_produtos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CadastroProdutos/widgets/data_filter.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';
import '../../controllers/cardapio_manager.dart';
import '../../controllers/cardapio_repository.dart';
import 'widgets/photo_gallery_mongo.dart';

class CardapioManagerPage extends StatelessWidget {
  final manager = CardapioManager();
  final repository = CardapioRepository();
  final mongoServiceDB = Get.put(MongoServiceDB());

  CardapioManagerPage({super.key}) {
    mongoServiceDB.fetchProducts();
  }

  // separar o collection e categoria
  // cada produto com adicional ser tratado diferente

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CARDAPIO DIGITAL DE {RUBY}'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextButton(onPressed: () {}, child: const Text("Procurar Produto")),
            TextButton(
                onPressed: () {
                  Get.to(PhotoGalleryScreen());
                },
                child: const CustomText(
                  text: "Galeria produtos",
                  color: Colors.white,
                )),
            TextButton(
                onPressed: () {
                  Get.to(const DataFiltered());
                },
                child: const CustomText(
                  text: "Filtrando Dados do mongo",
                  color: Colors.white,
                )),
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
                          : Colors
                              .green, // Cores alternadas para os contêineres
                      borderRadius:
                          BorderRadius.circular(10), // Borda arredondada
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        botoesSuperior(context, categoriasCardapio),
                        cardProduct(produtoCardapio),
                      ],
                    ),
                  );
                },
              ),
            ),
            showMongo()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            manager.criarCategoria();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CadastroDialog(produto: "produto");
              },
            );
          },
          tooltip: 'Criar Categoria',
          child: const Text('Criar Categoria')), //
    );
  }

  Widget cardProduct(
    produtoCardapio,
  ) {
    Future<List<String>> categoriasMongoDB =
        mongoServiceDB.getCategorias("cardapio-ruby");

    print(categoriasMongoDB);

    bool categoriaExiste = true;

    // Se a categoria existir, exibir o card do produto; caso contrário, retornar um container vazio
    return categoriaExiste
        ? Card(
            elevation: 5, // Elevação do card
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(child: Placeholder()),
                title: Text(
                  '${produtoCardapio["NOME"]}',
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("R\$ ${produtoCardapio["PRECO"].toString()} reais"),
                  ],
                ),
                trailing: CircleAvatar(
                  child: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "Editar",
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.edit),
                                ),
                                Text("Editar Produto"),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: "Deletar",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.delete_forever_rounded),
                            ),
                            Text("Deletar Produto"),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (String newValue) {},
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget showMongo() {
    return Container(
      height: 500,
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CadastroDialog(produto: produto);
                },
              );
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
