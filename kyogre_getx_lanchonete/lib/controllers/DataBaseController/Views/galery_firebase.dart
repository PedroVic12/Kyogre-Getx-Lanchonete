import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';

class FotoComDescricao {
  final Uint8List imageBytes;
  final String description;

  FotoComDescricao({required this.imageBytes, required this.description});
}

class FirebaseApiService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://groundon-citta-cardapio-default-rtdb.firebaseio.com';

  FirebaseApiService() {
    _dio.options.headers['Access-Control-Allow-Origin'] = '*';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<void> uploadImageWithDescription(
      Uint8List imageBytes, String description) async {
    try {
      final Map<String, dynamic> imageData = {
        "image": imageBytes.toString(),
        "description": description,
      };

      final response =
          await _dio.post('$_baseUrl/images.json', data: imageData);

      if (response.statusCode == 200) {
        print("Image uploaded successfully!");
      } else {
        throw Exception('Error uploading image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<List<FotoComDescricao>> getImagesWithDescriptions() async {
    try {
      final response = await _dio.get('$_baseUrl/images.json');

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        if (data == null) return [];

        if (data is Map<String, dynamic>) {
          return data.entries.map((entry) {
            final imageData = entry.value;
            return FotoComDescricao(
              imageBytes: Uint8List.fromList(List<int>.from(
                  imageData['image'].split(',').map((e) => int.parse(e)))),
              description: imageData['description'],
            );
          }).toList();
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Error retrieving images: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error retrieving images: $e');
    }
  }
}

class PhotoController extends GetxController {
  final RxList<FotoComDescricao> photos = <FotoComDescricao>[].obs;
  final TextEditingController descriptionController = TextEditingController();
  final FirebaseApiService firebaseService = FirebaseApiService();

  Future<void> uploadImage(FotoComDescricao image) async {
    try {
      await firebaseService.uploadImageWithDescription(
        image.imageBytes,
        image.description,
      );
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> fetchPhotosFromFirebase() async {
    try {
      final fetchedPhotos = await firebaseService.getImagesWithDescriptions();
      photos.assignAll(fetchedPhotos);
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  Future<void> pickFromGallery() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*'
      ..click();

    await input.onChange.first;
    final html.File file = input.files!.first;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoad.first;

    final List<int> imageBytes = List<int>.from(
      reader.result as List<int>,
    );

    final newPhoto = FotoComDescricao(
      imageBytes: Uint8List.fromList(imageBytes),
      description: descriptionController.text,
    );

    photos.add(newPhoto);
    uploadImage(newPhoto);
  }

  void clearPhotos() {
    photos.clear();
  }
}

class TasksPage extends StatelessWidget {
  final controller = Get.put(PhotoController());

  TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchPhotosFromFirebase();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller.descriptionController,
            decoration: const InputDecoration(
              hintText: 'Enter description',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.pickFromGallery(),
            child: const Text('Pick from Gallery'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  content: SizedBox(
                    width: 300,
                    height: 300,
                    child: Obx(() {
                      if (controller.photos.isEmpty) {
                        return const Center(
                          child: Text('No photos available'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: controller.photos.length,
                          itemBuilder: (context, index) {
                            final photo = controller.photos[index];
                            return Column(
                              children: [
                                Image.memory(photo.imageBytes),
                                Text(photo.description),
                                Divider(),
                              ],
                            );
                          },
                        );
                      }
                    }),
                  ),
                ),
              );
            },
            child: const Text('View Photos'),
          ),
        ],
      ),
    );
  }
}
