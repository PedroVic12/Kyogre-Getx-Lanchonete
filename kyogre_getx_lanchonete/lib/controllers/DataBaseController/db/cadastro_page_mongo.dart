import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/loading_widget.dart';
import 'package:kyogre_getx_lanchonete/database/controllers/MongoDBServices/mongo_service.dart';
import 'package:kyogre_getx_lanchonete/database/controllers/sqlServices/sql_service.dart';

class DataBasePage extends StatefulWidget {
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
        title: Text('Database Page'),
      ),
      body: ListView(
        children: [
          Expanded(
            child: Container(
                color: Colors.blueGrey,
                child: mongoServiceDB.products.isNotEmpty
                    ? const LoadingWidget()
                    : showMongo()),
          ),
          Expanded(
            child: Container(
                color: Colors.amber,
                child: sqlService.isLoading
                    ? const LoadingWidget()
                    : Text("Carregado!")),
          ),
        ],
      ),
    );
  }

  Widget showMongo() {
    return Obx(() => ListView.builder(
        itemCount: mongoServiceDB.products.length,
        itemBuilder: (context, index) {
          final product =
              mongoServiceDB.products[index] as Map<String, dynamic>;
          print("product = ${product}");

          if (product != null) {
            // // Converte o product para o tipo CardapioModel
            // final cardapioModel = CardapioModel.fromJson({
            //   '_id': product['_id'] ?? '=',
            //   'NOME': product['NOME'] ?? '=',
            //   'CATEGORIA': product['CATEGORIA'] ?? '=',
            //   'preco_1': product['preco_1'] ?? 0.0,
            //   'preco_2': product['preco_2'] ?? 0.0,
            //   'IGREDIENTES': product['IGREDIENTES'] ?? '=',
            //   'IMAGEM': product['IMAGEM'] ?? '=',
            // });

            // // Verifica se o nome não é nulo antes de exibi-lo
            // return ListTile(
            //   title: Text(cardapioModel.nome),
            //   subtitle: Text(cardapioModel.preco1.toString()),
            //   trailing: IconButton(
            //     icon: Icon(Icons.delete),
            //     onPressed: () =>
            //         mongoServiceDB.deleteProduct(cardapioModel.nome),
            //   ),
            // );
          } else {
            return const ListTile(
              title: Text('Sem nome'),
            );
          }
        }));
  }

  Widget showSQL() {
    return Obx(() => ListView.builder(
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
        ));
  }
}
