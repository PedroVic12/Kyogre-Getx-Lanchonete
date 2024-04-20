import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late mongo.Db db;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    connectToDatabase();
  }

  Future<void> connectToDatabase() async {
    db = await mongo.Db.create('mongodb://localhost:27017/products');
    await db.open();
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    final collection = db.collection('products');
    final productList = await collection.find().toList();
    setState(() {
      products = productList
          .map((json) => Product(
                name: json['name'],
                price: json['price'],
                imageUrl: json['imageUrl'],
              ))
          .toList();
    });
  }

  Future<void> addProduct(Product product) async {
    final collection = db.collection('products');
    await collection.insert({
      'name': product.name,
      'price': product.price,
      'imageUrl': product.imageUrl,
    });
    await fetchProducts();
  }

  Future<void> deleteProduct(String name) async {
    final collection = db.collection('products');
    await collection.remove(mongo.where.eq('name', name));
    await fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product CRUD'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: Image.network(product.imageUrl),
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteProduct(product.name),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addProduct(Product(
          name: 'New Product',
          price: 0.0,
          imageUrl: 'https://via.placeholder.com/150',
        )),
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }
}
