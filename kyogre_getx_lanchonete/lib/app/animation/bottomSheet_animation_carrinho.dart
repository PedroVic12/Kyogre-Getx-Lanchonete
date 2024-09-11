import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add To Cart Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Add To Cart Animation Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;
  double _totalPrice = 0.0; // Track total price

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 32, // Adjusted size for the cart icon
      width: 32,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          actions: [
            AddToCartIcon(
              key: cartKey,
              icon: const Icon(Icons.shopping_cart),
              badgeOptions: BadgeOptions(
                  active: true,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              onClick: _addToCart,
            );
          },
        ),
      ),
    );
  }

  void _addToCart(GlobalKey widgetKey, Product product) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());

    // Update total price
    setState(() {
      _totalPrice += product.price;
    });

    _showCartBottomSheet();
  }

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the sheet to be full height
      builder: (context) {
        return Container(
          color: Colors.blueGrey, // Set the container color to blueGrey
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Items:', style: TextStyle(fontSize: 20)),
                  Text('$_cartQuantityItems',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Price:', style: TextStyle(fontSize: 20)),
                  Text('\$${_totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle checkout logic here
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final Product product;
  final void Function(GlobalKey, Product) onClick;

  ProductCard({
    Key? key,
    required this.product,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onClick(widgetKey, product),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              key: widgetKey,
              width: 60,
              height: 60,
              color: Colors.transparent,
              child: Image.network(
                product.imageUrl,
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(height: 8),
            Text(product.name),
            const SizedBox(height: 4),
            Text('\$${product.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

// Sample product data
class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

final List<Product> products = [
  Product(
    name: 'Product 1',
    description: 'Description for Product 1',
    price: 10.99,
    imageUrl:
        'https://cdn.jsdelivr.net/gh/omerbyrk/add_to_cart_animation/example/assets/apple.png',
  ),
  Product(
    name: 'Product 2',
    description: 'Description for Product 2',
    price: 15.99,
    imageUrl:
        'https://cdn.jsdelivr.net/gh/omerbyrk/add_to_cart_animation/example/assets/apple.png',
  ),
  // Add more products here
];
