import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';
import 'package:get/get.dart';

class Product {
  final String name;
  final String description;
  final double price;

  Product({
    required this.name,
    required this.description,
    required this.price,
  });
}

class ProductRepository {
  List<Product> getPizzas() {
    return [
      Product(
          name: 'Margherita',
          description: 'Tomato, mozzarella, basil',
          price: 12.00),
      Product(
          name: 'Pepperoni',
          description: 'Pepperoni, mozzarella, tomato',
          price: 14.00),
      Product(
          name: 'BBQ Chicken',
          description: 'BBQ sauce, chicken, onions',
          price: 15.00),
      Product(
          name: 'Vegetarian',
          description: 'Assorted vegetables, mozzarella',
          price: 13.00),
      Product(
          name: 'Hawaiian',
          description: 'Ham, pineapple, cheese',
          price: 14.00),
    ];
  }

  List<Product> getSandwiches() {
    return [
      Product(
          name: 'BLT',
          description: 'Bacon, lettuce, tomato, mayo',
          price: 8.00),
      Product(
          name: 'Turkey Club',
          description: 'Turkey, bacon, lettuce, tomato',
          price: 9.00),
      Product(
          name: 'Grilled Cheese',
          description: 'Cheddar cheese, grilled bread',
          price: 7.00),
      Product(
          name: 'Ham & Cheese', description: 'Ham, cheese, bread', price: 8.00),
      Product(
          name: 'Veggie',
          description: 'Assorted vegetables, cheese',
          price: 8.00),
    ];
  }

  List<Product> getJuices() {
    return [
      Product(
          name: 'Orange Juice',
          description: 'Freshly squeezed orange juice',
          price: 5.00),
      Product(
          name: 'Apple Juice', description: '100% apple juice', price: 4.50),
      Product(
          name: 'Carrot Juice',
          description: 'Freshly squeezed carrot juice',
          price: 5.00),
      Product(
          name: 'Grapefruit Juice',
          description: 'Freshly squeezed grapefruit juice',
          price: 5.50),
      Product(
          name: 'Mixed Fruit Juice',
          description: 'Blend of various fruits',
          price: 6.00),
    ];
  }

  List<Product> getCoffees() {
    return [
      Product(
          name: 'Espresso', description: 'Strong black coffee', price: 3.00),
      Product(
          name: 'Latte',
          description: 'Espresso with steamed milk',
          price: 4.00),
      Product(
          name: 'Cappuccino',
          description: 'Espresso with frothy milk',
          price: 4.50),
      Product(
          name: 'Americano',
          description: 'Espresso with hot water',
          price: 3.50),
      Product(
          name: 'Mocha',
          description: 'Espresso with chocolate and milk',
          price: 5.00),
    ];
  }
}

class PageFlipController extends GetxController {
  final GlobalKey<PageFlipWidgetState> pageFlipKey;

  PageFlipController(this.pageFlipKey);

  void goToPage(int index) {
    final pageFlipState = pageFlipKey.currentState;
    if (pageFlipState != null) {
      pageFlipState.goToPage(index);
    }
    update();
  }
}

class ProductsPageFlip extends StatefulWidget {
  @override
  _ProductsPageFlipState createState() => _ProductsPageFlipState();
}

class _ProductsPageFlipState extends State<ProductsPageFlip>
    with SingleTickerProviderStateMixin {
  final ProductRepository repository = ProductRepository();
  final GlobalKey<PageFlipWidgetState> pageFlipKey =
      GlobalKey<PageFlipWidgetState>();
  late PageFlipController pageFlipController;
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    pageFlipController = PageFlipController(pageFlipKey);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
        pageFlipController.goToPage(_currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Categories'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Pizzas'),
            Tab(text: 'Sandwiches'),
            Tab(text: 'Juices'),
            Tab(text: 'Coffees'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PageFlipWidget(
            key: pageFlipKey,
            children: [
              _buildProductList(repository.getPizzas()),
            ],
          ),
          PageFlipWidget(
            key: UniqueKey(), // UniqueKey for each PageFlipWidget
            children: [
              _buildProductList(repository.getSandwiches()),
            ],
          ),
          PageFlipWidget(
            key: UniqueKey(), // UniqueKey for each PageFlipWidget
            children: [
              _buildProductList(repository.getJuices()),
            ],
          ),
          PageFlipWidget(
            key: UniqueKey(), // UniqueKey for each PageFlipWidget
            children: [
              _buildProductList(repository.getCoffees()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.food_bank),
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }
}
