import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoServiceDB extends GetxController {
  late mongo.Db db;
  List products = [];
  List<Map<String, dynamic>> productList = [];

  @override
  void initState() {
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
  }

  Future<void> addProduct(product) async {
    final collection = db.collection('KyogreDB');
    await collection.insert({
      'NOME': product.name,
      'preco_1': product.price,
      'IMAGEM': product.imageUrl,
    });
    await fetchProducts();
  }
}
