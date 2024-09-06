import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:better_page_turn/better_page_turn.dart';

// Your imports
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/firebase_services.dart';
import 'cardapio_exemplo_repository.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({super.key});

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  HorizontalFlipPageTurnController horizontalFlipPageTurnController =
      HorizontalFlipPageTurnController();

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
        // Animate the page turn to the corresponding tab index

        horizontalFlipPageTurnController.animToPositionWidget(_currentIndex,
            duration: const Duration(milliseconds: 350));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Digital Menu'),
        ),
        child: ListView(
          children: [
            // Custom Tab Bar with Icons and Text
            Container(
              height: 100,
              color: CupertinoColors.systemYellow,
              child: TabBar(
                isScrollable: true,
                enableFeedback: true,
                automaticIndicatorColorAdjustment: true,
                padding: const EdgeInsets.all(10),
                controller: _tabController,
                tabs: [
                  _buildTabItem(Icons.local_pizza, 'Pizzas', 0),
                  _buildTabItem(Icons.info, 'Sandwiches', 1),
                  _buildTabItem(Icons.local_drink, 'Juices', 2),
                  _buildTabItem(Icons.coffee, 'Coffees', 3),
                ],
              ),
            ),
            LayoutBuilder(builder: (context, constraints) {
              return HorizontalFlipPageTurn(
                children: [
                  _buildProductList(ProductRepository().getPizzas()),
                  _buildProductList(ProductRepository().getSandwiches()),
                  _buildProductList(ProductRepository().getJuices()),
                  _buildProductList(ProductRepository().getCoffees()),
                ],
                cellSize: Size(constraints.maxWidth, 600),
                controller: horizontalFlipPageTurnController,
              );
            }),
            //StoragePhotosWidger(),
          ],
        ),
      ),
    );
  }

  // Helper function to build each tab item
  Widget _buildTabItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //horizontalFlipPageTurnController.animToPositionWidget(index);

          _tabController.animateTo(index);
        });
      },
      child: Container(
        height: 100,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade300,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 5),
            CustomText(text: label, size: 16),
          ],
        ),
      ),
    );
  }

  // Function to build the product list for each category
  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }
}
