import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/template/produtos_model.dart';

class FirebaseServices {
  //fireabse storage configure
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
      // TODO
      print(e.toString());
    }
  }

  String extactPathFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String encodedPath = uri.pathSegments.last;
    return Uri.decodeComponent(encodedPath);
    //return url.split('produto_imagens%2F')[1].split('?')[0];
  }

  // Salvar um produto no Firestore
  Future<void> addProduto(ProdutoModel produto) async {
    await _firestore
        .collection('produtos')
        .add(produto as Map<String, dynamic>);
  }

  // Fazer upload de imagem para o Firebase Storage
  Future<String> uploadImage() async {
    try {
      isUploading = true;

      final ImagePicker pikcer = ImagePicker();
      final XFile? image = await pikcer.pickImage(source: ImageSource.gallery);

      if (image == null) {
        isUploading = false;
        return '';
      }

      File file = File(image.path);
      String filePath = "produto_imagens/${DateTime.now()}.png";
      await _storage.ref(filePath).putFile(file);
      String downloadUrl = await _storage.ref(filePath).getDownloadURL();
      imagensUrls.add(downloadUrl);
      isUploading = false;
    } on Exception catch (e) {
      // TODO
      print("\n\nError ao fazer upload da imagem: $e");
    }

    // Add a return statement at the end
    return '';
  }
}
