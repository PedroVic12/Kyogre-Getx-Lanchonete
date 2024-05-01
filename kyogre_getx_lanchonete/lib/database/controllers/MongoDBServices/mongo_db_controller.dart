import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDBController extends GetxController {
  late final Db db;
  final relatorios = [].obs;
  final url =
      "mongodb+srv://pedrovictorveras:admin@cluster.s1yzg4o.mongodb.net/"
      "?retryWrites=true&w=majority&appName=Cluster";

  @override
  void onInit() {
    super.onInit();
    conectar("cardapio-ruby");
  }

  Future<Db> conectar(String dbName) async {
    try {
      final mongoDb = await Db.create(url);
      await mongoDb.open();
      this.db = mongoDb;
      print("\nConexão realizada com sucesso");

      return mongoDb;
    } catch (e) {
      print("Não conectado! $e");
      throw e;
    }
  }

  Future<void> desconectar() async {
    await db.close();
  }

  Future<void> getRelatorios(String dbName) async {
    final db = await conectar(dbName);
    final collection = db.collection('relatorio_records');
    final documentos = await collection.find().toList();
    print(documentos);
    documentos.forEach((element) {
      relatorios.add(element);
    });
  }

  Future<void> inserirDocumento(String dbName, String collectionName,
      Map<String, dynamic> documento) async {
    final db = await conectar(dbName);
    final collection = db.collection(collectionName);
    await collection.insert(documento);
  }

  Future<void> atualizarDocumento(String dbName, String collectionName,
      Map<String, dynamic> filtro, Map<String, dynamic> atualizacoes) async {
    final db = await conectar(dbName);
    final collection = db.collection(collectionName);
    await collection.update(filtro, atualizacoes);
  }

  Future<void> deletarDocumento(
      String dbName, String collectionName, Map<String, dynamic> filtro) async {
    final db = await conectar(dbName);
    final collection = db.collection(collectionName);
    await collection.remove(filtro);
  }

  Future<Map<String, dynamic>?> lerDocumento(
      String dbName, String collectionName, Map<String, dynamic> filtro) async {
    final db = await conectar(dbName);
    final collection = db.collection(collectionName);
    final documento = await collection.findOne(filtro);
    return documento;
  }

  Future<List<String?>> listarColecoes(String dbName) async {
    final db = await conectar(dbName);
    final colecoes = await db.getCollectionNames();
    return colecoes;
  }
}
