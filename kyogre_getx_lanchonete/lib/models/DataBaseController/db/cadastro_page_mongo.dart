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

class MongoDBexample extends StatefulWidget {
  const MongoDBexample({super.key});

  @override
  State<MongoDBexample> createState() => _MongoDBexampleState();
}

class _MongoDBexampleState extends State<MongoDBexample> {
  late mongo.Db db;
  List<Product> products = [];
  List<Map<String, dynamic>> productList = [];

  @override
  void initState() {
    super.initState();
    connectToDatabase();
  }

  Future<void> connectToDatabaseCamorim() async {
    String uri =
        "mongodb+srv://pedrovictorveras:admin@cluster.s1yzg4o.mongodb.net/?retryWrites=true&w=majority&appName=Cluster";
    String database_name = "Relatorio_OS_DB";
    String collection_name = "relatorio_records";
    db = await mongo.Db.create(uri);
    await db.open();
    final collection = db.collection(collection_name);
    final productList = await collection.find().toList();
    print(collection);
    print(productList);
    setState(() {
      this.productList = productList;
    });
  }

  Future<void> connectToDatabase() async {
    db = await mongo.Db.create('mongodb://localhost:27017');
    await db.open();
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    final collection = db.collection('KyogreDB');
    final productList = await collection.find().toList();
    print(collection);
    print(productList);

    setState(() {
      products = productList
          .map((json) => Product(
                name: json['NOME'],
                price: json['preco_1'],
                imageUrl: json['IMAGEM'],
              ))
          .toList();
    });
  }

  Future<void> addProduct(Product product) async {
    final collection = db.collection('KyogreDB');
    await collection.insert({
      'NOME': product.name,
      'preco_1': product.price,
      'IMAGEM': product.imageUrl,
    });
    await fetchProducts();
  }

  Future<void> deleteProduct(String name) async {
    final collection = db.collection('KyogreDB');
    await collection.remove(mongo.where.eq('NOME', name));
    await fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product CRUD'),
      ),
      body: ListView(
        children: [
          showDB(),
          products.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
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
        ],
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

  Widget showDB() {
    connectToDatabaseCamorim();
    return Container(
      child: productList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ListTile(
                  title: Text('Product ${index + 1}'),
                  subtitle: Text('Details: $product'),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }
}
