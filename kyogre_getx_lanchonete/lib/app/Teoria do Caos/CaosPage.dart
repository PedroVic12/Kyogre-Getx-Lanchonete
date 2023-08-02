import 'package:flutter/material.dart';

import '../../models/DataBaseController/DataBaseController.dart';

class CaosPage extends StatefulWidget {
  const CaosPage({Key? key}) : super(key: key);

  @override
  State<CaosPage> createState() => _CaosPageState();
}

class _CaosPageState extends State<CaosPage> {
  DataBaseController _dataBaseController = DataBaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teoria do Caos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder<List<Produto>>(
              future: _dataBaseController.getSanduichesTradicionais(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os dados da categoria Sanduíches Tradicionais'),
                  );
                } else if (snapshot.hasData) {
                  List<Produto> produtos = snapshot.data!;
                  if (produtos.isEmpty) {
                    return Center(
                      child: Text('Nenhum produto encontrado na categoria Sanduíches Tradicionais'),
                    );
                  }

                  return ProdutosListView(produtos: produtos);
                } else {
                  return Center(
                    child: Text('Não foi possível ler os dados da categoria Sanduíches Tradicionais'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
