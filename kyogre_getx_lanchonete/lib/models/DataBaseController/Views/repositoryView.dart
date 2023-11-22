









import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository_db_controller.dart';
import '../template/produtos_model.dart';

class RepositoryListView extends StatefulWidget {
  @override
  _RepositoryListViewState createState() => _RepositoryListViewState();
}

class _RepositoryListViewState extends State<RepositoryListView> {
  final RepositoryDataBaseController controller = Get.put(
      RepositoryDataBaseController());

  @override
  void initState() {
    super.initState();
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos - REPOSITORY'),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return buildListViewProdutosRepository();
        }
      }),
    );
  }


  Widget buildListViewProdutosRepository() {
    return ListView.builder(
      itemCount: controller.dataBase_Array
          .expand((x) => x)
          .length,
      itemBuilder: (context, index) {
        final produto = controller.dataBase_Array.expand((x) => x).elementAt(
            index);
        return ListTile(
          title: Text(produto.nome),
          subtitle: Text('Categoria: ${produto.categoria}'),
        );
      },
    );
  }

  Widget _carregandoProdutos() {
    return FutureBuilder<List<List<ProdutoModel>>>(
      future: controller.fetchAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Ocorreu um erro ao carregar os produtos.'));
        } else {
          return Container(
            height: 500,
            color: Colors.purpleAccent,
            child: ListView(
              children: [
                Card(
                    color: Colors.blueGrey,
                    child: Text(
                        'Produtos JSON = ${controller.dataBase_Array}')),

                buildListViewProdutosRepository()
              ],
            ),
          );
        }
      },
    );
  }
}