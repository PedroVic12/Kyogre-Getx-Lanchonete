import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/Teoria%20do%20Caos/MenuScrollLateral.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';

class CaosPage extends StatefulWidget {
  const CaosPage({Key? key}) : super(key: key);

  @override
  State<CaosPage> createState() => _CaosPageState();
}

class _CaosPageState extends State<CaosPage> {
  late Future<List<Produto>> _sanduichesFuture;

  @override
  void initState() {
    super.initState();
    // Chama o método que lê os dados do JSON de Sanduiches ao iniciar a página
    _sanduichesFuture = _loadSanduichesData();
  }

  Future<List<Produto>> _loadSanduichesData() async {
    DataBaseController dataBaseController = DataBaseController();
    return dataBaseController.getSanduiches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teoria do Caos'),
      ),
      body: Column(
        children: [
          Text('data'), // Opcional, apenas para teste
          FutureBuilder<List<Produto>>(
            future: _sanduichesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(), // Exibe o CircularProgress enquanto carrega os dados
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao carregar os dados do JSON'), // Exibe mensagem de erro, caso ocorra algum problema
                );
              } else if (snapshot.hasData) {
                // Se os dados foram carregados corretamente, exibe o ListView
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Produto produto = snapshot.data![index];
                      return ListTile(
                        title: Text(produto.nome),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Preço: R\$ ${produto.preco}'),
                            //Text('Ingredientes: ${produto.ingredientes}'), // Substitua "ingredientes" pelo nome do atributo correto em seu modelo de Produto

                          ],
                        ),
                        leading: CircleAvatar(
                          //backgroundImage: NetworkImage(produto.imageUrl),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text('Não foi possível ler o JSON'), // Exibe mensagem caso não haja dados
                );
              }
            },
          ),

        ],
      ),
    );
  }
}
