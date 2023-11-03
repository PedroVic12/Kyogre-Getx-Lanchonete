import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CatalogoProdutos/CatalogoProdutosController.dart';
import '../../MenuCardapioScroll/CardapioProdutosView.dart';
import '../produtos_model.dart';
import 'MenuCategoriasScroll.dart';

class MenuCardapioScollPage extends StatefulWidget {
  const MenuCardapioScollPage({super.key});

  @override
  State<MenuCardapioScollPage> createState() => _MenuCardapioScollPageState();
}

class _MenuCardapioScollPageState extends State<MenuCardapioScollPage> {
  final CatalogoProdutosController catalogoProdutosController = Get.put(CatalogoProdutosController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Cardapio 1')),
      body: Column(
        children: [
          MenuCategoriasScrollGradientWidget(
            onCategorySelected: (index) {
              setState(
                      () {}); // Isso forçará a reconstrução do widget e atualizará os produtos exibidos.
            },
          ),

          //topNavigator(size),

          Expanded(
            child: Container(
              color: Colors.lime,
              child: pageView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageView() {
    return PageView(
      children: const [
        Center(child: Text('Produtos Hamburguer')),
        Center(child: Text('Produtos PIzza')),
        Center(child: Text('Mobile Itens')),
        // ... outros itens
      ],
    );
  }

  Widget topNavigator(Size size) {
    List<ItemModel> items = [
      ItemModel('Fashion'),
      ItemModel('Electronics'),
      ItemModel('Beauty'),
      ItemModel('Electronics'),
      ItemModel('Electronics'),
      ItemModel('Electronics'),
      ItemModel('Electronics'),

      // ... outros itens
    ];

    return Container(
      height: 60,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.indigo.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return menuButton(items[index]);
        },
      ),
    );
  }

  Widget menuButton(ItemModel item) {
    return Container(
      width: 120,
      child: Center(
        child: TextButton(
          onPressed: () {
            print("Item ${item.label} clicado!");
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.all(width: 2, color: Colors.white),
            ),
            child: Text(
              item.label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
