import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';

class LoadingWidget extends StatefulWidget {
  final Widget content;
  final Duration duration;

  LoadingWidget({required this.content, this.duration = const Duration(seconds: 1)});

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(widget.duration, () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : widget.content;
  }
}

// Agora vamos usar o LoadingWidget no CaosPage

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
      body: FutureBuilder<List<Produto>>(
        future: _dataBaseController.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os produtos'),
            );
          } else if (snapshot.hasData) {
            List<Produto> produtos = snapshot.data!;
            return LoadingWidget(
              content: ListView(
                children: [
                  ProdutosListView(categoria: 'Sanduíches Tradicionais', produtos: produtos.where((p) => p.tipo_produto == 'Sanduíches Tradicionais').toList()),
                  ProdutosListView(categoria: 'Açaí e Pitaya', produtos: produtos.where((p) => p.tipo_produto == 'Açaí e Pitaya').toList()),
                  ProdutosListView(categoria: 'Petiscos', produtos: produtos.where((p) => p.tipo_produto == 'Petiscos').toList()),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Não foi possível carregar os produtos'),
            );
          }
        },
      ),
    );
  }
}