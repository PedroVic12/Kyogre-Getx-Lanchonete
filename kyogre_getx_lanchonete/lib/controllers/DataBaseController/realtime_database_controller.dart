import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("cardapio");

  Future<void> createItem({
    required String nome,
    required double preco,
    required String descricao,
    required String adicional,
  }) async {
    await _dbRef.push().set({
      "nome": nome,
      "preco": preco,
      "descricao": descricao,
      "adicional": adicional,
    });
  }

  Future<List<Map<dynamic, dynamic>>> getItems() async {
    DataSnapshot snapshot = await _dbRef.get();

    if (snapshot.exists) {
      List<Map<dynamic, dynamic>> items = [];
      final data = snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        items.add({
          "id": key,
          "nome": value["nome"],
          "preco": value["preco"],
          "descricao": value["descricao"],
          "adicional": value["adicional"],
        });
      });
      return items;
    }
    return [];
  }

  Future<void> deleteItem(String id) async {
    await _dbRef.child(id).remove();
  }
}

class FirebaseController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var cardapioList = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCardapioItems();
  }

  void fetchCardapioItems() async {
    try {
      isLoading.value = true;
      var items = await _firebaseService.getItems();
      cardapioList.value = items;
    } finally {
      isLoading.value = false;
    }
  }

  void addItem(
      String nome, double preco, String descricao, String adicional) async {
    await _firebaseService.createItem(
      nome: nome,
      preco: preco,
      descricao: descricao,
      adicional: adicional,
    );
    fetchCardapioItems(); // Atualiza a lista após adicionar o item
  }

  void deleteItem(String id) async {
    await _firebaseService.deleteItem(id);
    fetchCardapioItems(); // Atualiza a lista após deletar
  }
}

class PageAdminCardapio extends StatelessWidget {
  final FirebaseController _firebaseController = Get.put(FirebaseController());

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _adicionalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cardápio"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Formulário para adicionar novos itens
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: _precoController,
                  decoration: InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                ),
                TextField(
                  controller: _adicionalController,
                  decoration: InputDecoration(labelText: 'Adicional'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_nomeController.text.isNotEmpty &&
                        _precoController.text.isNotEmpty &&
                        _descricaoController.text.isNotEmpty &&
                        _adicionalController.text.isNotEmpty) {
                      _firebaseController.addItem(
                        _nomeController.text,
                        double.parse(_precoController.text),
                        _descricaoController.text,
                        _adicionalController.text,
                      );

                      // Limpar campos após adicionar
                      _nomeController.clear();
                      _precoController.clear();
                      _descricaoController.clear();
                      _adicionalController.clear();
                    }
                  },
                  child: Text("Adicionar Item"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (_firebaseController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (_firebaseController.cardapioList.isEmpty) {
                  return Center(child: Text("Nenhum item no cardápio"));
                }

                return ListView.builder(
                  itemCount: _firebaseController.cardapioList.length,
                  itemBuilder: (context, index) {
                    final item = _firebaseController.cardapioList[index];
                    return ListTile(
                      title: Text(item['nome']),
                      subtitle: Text(
                          "Preço: R\$ ${item['preco']} \nDescrição: ${item['descricao']} \nAdicional: ${item['adicional']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _firebaseController.deleteItem(item['id']);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
