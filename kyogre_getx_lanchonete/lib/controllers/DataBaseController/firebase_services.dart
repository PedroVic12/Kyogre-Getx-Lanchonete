import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProdutoModel {
  String nome;
  String categoria;
  double preco_1;
  String? description;
  String? sub_categoria;
  double? preco_2;
  String? ingredientes;
  String? imagem;
  Map? Adicionais;

  ProdutoModel({
    required this.nome,
    required this.preco_1,
    required this.categoria,
    this.sub_categoria,
    this.preco_2,
    this.ingredientes,
    this.imagem,
    Map? Adicionais,
  }) : Adicionais = Adicionais ?? {} {
    sub_categoria ??= "";
    ingredientes ??= "";
    description ??= "";
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'categoria': categoria,
      'preco_1': preco_1,
      'preco_2': preco_2,
      'ingredientes': ingredientes,
      'imagem': imagem,
      "sub_categoria": sub_categoria,
    };
  }

  // Factory constructor para converter JSON em um objeto ProdutoModel
  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      nome: json['nome'],
      categoria: json['categoria'],
      preco_1: json['preco_1'].toDouble(),
      preco_2: json['preco_2']?.toDouble(),
      sub_categoria: json["sub_categoria"],
      ingredientes: json['ingredientes'],
      imagem: json['imagem'],
    );
  }
}

class FirebaseServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> imagensUrls = [];

  bool isLoading = false;
  bool isUploading = false;

  // Função para ler produtos do Firestore
  Future<List<ProdutoModel>> readData() async {
    final ref = _firestore.collection('produtos');
    final result = await ref.get();

    return result.docs.map((doc) => ProdutoModel.fromJson(doc.data())).toList();
  }

  // Função para adicionar um produto ao Firestore
  Future<void> addProduto(ProdutoModel produto) async {
    await _firestore.collection('produtos').add(produto.toJson());
  }

  Future<void> fetchImagens() async {
    isLoading = true;
    final ref = _storage.ref('produto_imagens');
    final result = await ref.listAll();
    imagensUrls =
        await Future.wait(result.items.map((e) => e.getDownloadURL()));
    isLoading = false;
  }

  Future<void> deleteImagem(String imageUrl) async {
    try {
      imagensUrls.remove(imageUrl);
      final String path = extactPathFromUrl(imageUrl);
      await _storage.ref(path).delete();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  String extactPathFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String encodedPath = uri.pathSegments.last;
    return Uri.decodeComponent(encodedPath);
  }

  Future<String> uploadImage() async {
    try {
      isUploading = true;

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        isUploading = false;
        return '';
      }

      File file = File(image.path);
      String filePath =
          "produto_imagens/${DateTime.now().toIso8601String()}.png";
      await _storage.ref(filePath).putFile(file);
      String downloadUrl = await _storage.ref(filePath).getDownloadURL();
      imagensUrls.add(downloadUrl);
      isUploading = false;
      return downloadUrl;
    } on Exception catch (e) {
      print("Error ao fazer upload da imagem: $e");
      return '';
    }
  }
}

class StoragePhotosWidget extends StatefulWidget {
  const StoragePhotosWidget({super.key});

  @override
  _StoragePhotosWidgetState createState() => _StoragePhotosWidgetState();
}

class _StoragePhotosWidgetState extends State<StoragePhotosWidget> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    await firebaseServices.fetchImagens();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () async {
              String url = await firebaseServices.uploadImage();
              if (url.isNotEmpty) {
                setState(() {});
              }
            },
            icon: Icon(Icons.add)),
        firebaseServices.imagensUrls.isNotEmpty
            ? Image.network(firebaseServices.imagensUrls[0])
            : Container(),
        firebaseServices.imagensUrls.isNotEmpty
            ? IconButton(
                onPressed: () async {
                  await firebaseServices
                      .deleteImagem(firebaseServices.imagensUrls[0]);
                  setState(() {});
                },
                icon: Icon(Icons.delete))
            : Container(),
      ],
    );
  }
}

class ProdutoScreen extends StatefulWidget {
  @override
  _ProdutoScreenState createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _createProduto() async {
    final produto = ProdutoModel(
      nome: "Produto Teste",
      preco_1: 10.0,
      categoria: "Teste Categoria",
    );
    await firebaseServices.addProduto(produto);
  }

  Future<void> _readProdutos() async {
    List<ProdutoModel> produtos = await firebaseServices.readData();
    produtos.forEach((produto) {
      print("Produto: ${produto.nome}, Preço: ${produto.preco_1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Produtos"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _createProduto,
            child: Text("Criar Produto"),
          ),
          ElevatedButton(
            onPressed: _readProdutos,
            child: Text("Ler Produtos"),
          ),
          StoragePhotosWidget(),
        ],
      ),
    );
  }
}
