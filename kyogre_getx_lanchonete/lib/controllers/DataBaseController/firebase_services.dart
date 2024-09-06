import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/template/produtos_model.dart';

class FirebaseServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> imagensUrls = [];

  bool isLoading = false;
  bool isUploading = false;

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

  Future<void> addProduto(ProdutoModel produto) async {
    await _firestore
        .collection('produtos')
        .add(produto.toJson()); // Assume que ProdutoModel tem um método toMap()
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

class StoragePhotosWidger extends StatefulWidget {
  const StoragePhotosWidger({super.key});

  @override
  _StoragePhotosWidgerState createState() => _StoragePhotosWidgerState();
}

class _StoragePhotosWidgerState extends State<StoragePhotosWidger> {
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
