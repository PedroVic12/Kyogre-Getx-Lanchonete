import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:image_picker/image_picker.dart';

class SQLControllerService {
  static const String tableName = 'produtos';
  static Database? _db;

  Future<void> initDB() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/produtos.db';

    _db = await databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            preco_1 REAL NOT NULL,
            preco_2 REAL,
            ingredientes TEXT,
            descricao TEXT,
            imagem TEXT
          )
        ''');

            // Insere dados de exemplo após criar o banco
            await _insertInitialData();
          },
        ));
  }

  // Função para inserir dados automaticamente
  Future<void> _insertInitialData() async {
    final List<Map<String, dynamic>> produtosExemplo = [
      {
        'nome': 'Pizza Margherita',
        'preco_1': 25.99,
        'preco_2': 30.00,
        'ingredientes': 'Tomate, Queijo, Manjericão',
        'descricao': 'Pizza clássica italiana com queijo e manjericão.',
        'imagem': null,
      },
      {
        'nome': 'Hambúrguer',
        'preco_1': 12.50,
        'preco_2': null,
        'ingredientes': 'Carne, Queijo, Alface, Tomate',
        'descricao': 'Hambúrguer suculento com ingredientes frescos.',
        'imagem': null,
      },
      {
        'nome': 'Salada Caesar',
        'preco_1': 10.00,
        'preco_2': null,
        'ingredientes': 'Alface, Croutons, Queijo, Molho Caesar',
        'descricao': 'Salada fresca com molho Caesar.',
        'imagem': null,
      }
    ];

    for (var produto in produtosExemplo) {
      await createProduto(
        nome: produto['nome'],
        preco_1: produto['preco_1'],
        preco_2: produto['preco_2'],
        ingredientes: produto['ingredientes'],
        descricao: produto['descricao'],
        imagemBase64: produto['imagem'],
      );
    }
  }

  Future<int> createProduto({
    required String nome,
    required double preco_1,
    double? preco_2,
    String? ingredientes,
    String? descricao,
    String? imagemBase64,
  }) async {
    final produto = {
      'nome': nome,
      'preco_1': preco_1,
      'preco_2': preco_2,
      'ingredientes': ingredientes,
      'descricao': descricao,
      'imagem': imagemBase64, // Armazenando a imagem como string Base64
    };

    return await _db!.insert(tableName, produto);
  }

  Future<List<Map<String, dynamic>>> getProdutos() async {
    return await _db!.query(tableName);
  }

  Future<void> deleteProduto(int id) async {
    await _db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}

class ImageService {
  final ImagePicker picker = ImagePicker();

  Future<String?> pickImageAsBase64() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    File file = File(image.path);
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  // Função para converter uma string Base64 de volta para Image
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}

class CadastroProdutosPage extends StatefulWidget {
  @override
  _CadastroProdutosPageState createState() => _CadastroProdutosPageState();
}

class _CadastroProdutosPageState extends State<CadastroProdutosPage> {
  final SQLControllerService _dbService = SQLControllerService();
  final ImageService _imageService = ImageService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  String? _imagemBase64;

  @override
  @override
  void initState() {
    super.initState();
    _dbService.initDB().then((_) {
      setState(() {}); // Atualiza a UI após a inserção dos dados
    });
  }

  Future<void> _salvarProduto() async {
    if (_nomeController.text.isNotEmpty && _precoController.text.isNotEmpty) {
      await _dbService.createProduto(
        nome: _nomeController.text,
        preco_1: double.parse(_precoController.text),
        descricao: _descricaoController.text,
        imagemBase64: _imagemBase64,
      );

      _limparFormulario();
      setState(() {}); // Atualiza a UI
    }
  }

  Future<void> _deletarProduto(int id) async {
    await _dbService.deleteProduto(id);
    setState(() {}); // Atualiza a UI
  }

  Future<void> _escolherImagem() async {
    final imagemBase64 = await _imageService.pickImageAsBase64();
    if (imagemBase64 != null) {
      setState(() {
        _imagemBase64 = imagemBase64;
      });
    }
  }

  void _limparFormulario() {
    _nomeController.clear();
    _precoController.clear();
    _descricaoController.clear();
    _imagemBase64 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Produtos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _escolherImagem,
              child: Text('Escolher Imagem'),
            ),
            if (_imagemBase64 != null)
              _imageService.imageFromBase64String(_imagemBase64!),
            ElevatedButton(
              onPressed: _salvarProduto,
              child: Text('Salvar Produto'),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _dbService.getProdutos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  final produtos = snapshot.data!;

                  return ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      final produto = produtos[index];

                      return ListTile(
                        title: Text(produto['nome']),
                        subtitle: Text('R\$ ${produto['preco_1']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deletarProduto(produto['id']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
