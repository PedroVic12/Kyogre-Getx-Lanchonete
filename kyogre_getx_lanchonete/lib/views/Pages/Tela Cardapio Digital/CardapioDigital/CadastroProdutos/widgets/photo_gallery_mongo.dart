import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class PhotoWithDescription {
  final Uint8List imageBytes;
  final String description;

  PhotoWithDescription({
    required this.imageBytes,
    required this.description,
  });
}

class PhotoGalleryController extends GetxController {
  final RxList<PhotoWithDescription> photos = <PhotoWithDescription>[].obs;
  final TextEditingController descriptionController = TextEditingController();

  Future<void> takePhoto() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*';
    input.click();

    await input.onChange.first;
    final html.File file = input.files!.first;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoad.first;

    final List<int> imageBytes = List<int>.from(
      reader.result as List<int>,
    );

    photos.add(
      PhotoWithDescription(
        imageBytes: Uint8List.fromList(imageBytes),
        description: descriptionController.text,
      ),
    );
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

    photos.add(
      PhotoWithDescription(
        imageBytes: Uint8List.fromList(imageBytes),
        description: descriptionController.text,
      ),
    );
  }

  void clearPhotos() {
    photos.clear();
  }
}

class PhotoGalleryScreen extends StatelessWidget {
  final controller = Get.put(PhotoGalleryController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            child: TextField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter description',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // ElevatedButton(
              //   onPressed: () => controller.takePhoto(),
              //   child: const Text('Take Photo'),
              // ),
              // const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () => controller.pickFromGallery(),
                child: const Text('Pick from Gallery'),
              ),
              const SizedBox(height: 20),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  content: Container(
                    //width: MediaQuery.of(context).size.width * 0.8,
                    //height: MediaQuery.of(context).size.height * 0.8,
                    width: 200,
                    height: 200,

                    child: GetBuilder<PhotoGalleryController>(
                      builder: (controller) {
                        if (controller.photos.isEmpty) {
                          return const Center(
                            child: Text('No photos available'),
                          );
                        } else {
                          return CarouselSlider.builder(
                            itemCount: controller.photos.length,
                            itemBuilder: (context, index, _) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.memory(
                                      controller.photos[index].imageBytes,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(controller.photos[index].description),
                                ],
                              );
                            },
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            ),
                          );
                        }
                      },
                    ),
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
