import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cadastro_screen.dart';
import 'produto_cardapio.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProdutoCardapio> produtos = [];

  @override
  void initState() {
    super.initState();
    _fetchProdutos();
  }

  Future<void> _fetchProdutos() async {
    final response = await http.get(Uri.parse('http://seu_servidor_django/api/produto_cardapio/'));
    if (response.statusCode == 200) {
      List<dynamic> produtosJson = json.decode(response.body);
      setState(() {
        produtos = produtosJson.map((json) => ProdutoCardapio.fromJson(json)).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar produtos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos do Cardápio'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastroScreen()),
              );
              _fetchProdutos();  // Atualiza a lista após cadastro
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Card(
            child: ListTile(
              leading: produto.imgUrl != null
                  ? Image.network('http://seu_servidor_django${produto.imgUrl}')
                  : Icon(Icons.fastfood),
              title: Text(produto.nome),
              subtitle: Text(produto.descricao),
              trailing: Text('R\$ ${produto.preco[0].toStringAsFixed(2)}'),
              onTap: () {
                // Aqui você pode adicionar a lógica para exibir mais detalhes do produto
              },
            ),
          );
        },
      ),
    );
  }
}