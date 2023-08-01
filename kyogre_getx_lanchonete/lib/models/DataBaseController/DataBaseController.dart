import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseController {
  // Instância do Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obter os dados de uma coleção específica
  Future<List<Map<String, dynamic>>> getCollectionData(String collectionName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection(collectionName).get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Erro ao obter os dados: $e');
      return [];
    }
  }

  // Método para obter os dados de um documento específico em uma coleção
  Future<Map<String, dynamic>?> getDocumentData(String collectionName, String documentId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection(collectionName).doc(documentId).get();

      return snapshot.data();
    } catch (e) {
      print('Erro ao obter os dados do documento: $e');
      return null;
    }
  }
}
