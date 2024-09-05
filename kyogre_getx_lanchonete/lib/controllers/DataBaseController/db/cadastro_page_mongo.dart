import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';
import 'package:kyogre_getx_lanchonete/database/controllers/MongoDBServices/mongo_service.dart';
import 'package:kyogre_getx_lanchonete/database/controllers/sqlServices/sql_service.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CadastroProdutos/cardapio_cadatro_produtos_mongo.dart';

class DataBasePage extends StatefulWidget {
  const DataBasePage({super.key});

  @override
  State<DataBasePage> createState() => _DataBasePageState();
}

class _DataBasePageState extends State<DataBasePage> {
  final MongoServiceDB mongoServiceDB = Get.put(MongoServiceDB());
  final SQLiteService sqlService = Get.put(SQLiteService());

  void iniciarState() async {
    await mongoServiceDB.fetchProducts();
    await sqlService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    iniciarState();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Page'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          TextButton(
              child: const Text("Cardapio Manager"),
              onPressed: () {
                Get.to(CardapioManagerPage());
              }),
          Container(
            color: Colors.blueGrey,
            height: 500,
            child: showMongo(),
          ),
          Container(
            color: Colors.amber,
            height: 500,
            child: showSQL(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newProduct = {
            "NOME": "Produto Teste",
            "preco_1": 10.0,
            "IMAGEM": "https://via.placeholder.com/150",
          };
          mongoServiceDB.addProduct(newProduct);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget showMongo() {
    return GetBuilder<MongoServiceDB>(
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
                    onPressed: () => controller.deleteProduct(product["NOME"]),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget showSQL() {
    return GetBuilder<SQLiteService>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return const Center(child: Text('Nenhum produto encontrado.'));
        } else {
          // Se houver produtos, exibe-os usando ListView.builder
          return ListView.builder(
            itemCount: sqlService.products.length,
            itemBuilder: (context, index) {
              final product = sqlService.products[index];
              return ListTile(
                title: Text(product["nome"] ?? 'Sem nome'),
                subtitle: Text({product["ano"] ?? 'Sem ano'}.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => sqlService.deleteProduct(product["nome"]),
                ),
              );
            },
          );
        }
      },
    );
  }
}
