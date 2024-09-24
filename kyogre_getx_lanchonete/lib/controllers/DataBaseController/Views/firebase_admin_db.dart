import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';

// Task model
class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}

// Photo model (renamed from FotoComDescricao)
class Photo {
  final Uint8List imageBytes;
  final String description;

  Photo({required this.imageBytes, required this.description});
}

// Repository class
class Repository {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://groundon-citta-cardapio-default-rtdb.firebaseio.com';

  Repository() {
    _dio.options.headers['Access-Control-Allow-Origin'] = '*';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  // Task operations
  Future<List<Task>> getTasks() async {
    try {
      final response = await _dio.get('$_baseUrl/tasks.json');
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = response.data;
        if (data == null) return [];
        return data.entries
            .map((e) => Task.fromJson({...e.value, 'id': e.key}))
            .toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error getting tasks: $e');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _dio.post('$_baseUrl/tasks.json', data: task.toJson());
    } catch (e) {
      throw Exception('Error adding task: $e');
    }
  }

  // Photo operations
  Future<void> uploadPhoto(Photo photo) async {
    try {
      final Map<String, dynamic> imageData = {
        "image": photo.imageBytes.toString(),
        "description": photo.description,
      };
      await _dio.post('$_baseUrl/images.json', data: imageData);
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<List<Photo>> getPhotos() async {
    try {
      final response = await _dio.get('$_baseUrl/images.json');
      if (response.statusCode == 200) {
        final dynamic data = response.data;
        if (data == null) return [];
        if (data is Map<String, dynamic>) {
          return data.entries.map((entry) {
            final imageData = entry.value;
            return Photo(
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

// Controller
class TasksController extends GetxController {
  final Repository _repository = Repository();
  final RxList<Task> tasks = <Task>[].obs;
  final RxList<Photo> photos = <Photo>[].obs;
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController photoDescriptionController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    fetchPhotos();
  }

  Future<void> fetchTasks() async {
    try {
      final fetchedTasks = await _repository.getTasks();
      tasks.assignAll(fetchedTasks);
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> addTask() async {
    try {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: taskTitleController.text,
        description: taskDescriptionController.text,
      );
      await _repository.addTask(newTask);
      tasks.add(newTask);
      taskTitleController.clear();
      taskDescriptionController.clear();
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> fetchPhotos() async {
    try {
      final fetchedPhotos = await _repository.getPhotos();
      photos.assignAll(fetchedPhotos);
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  Future<void> pickAndUploadPhoto() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*'
      ..click();

    await input.onChange.first;
    final html.File file = input.files!.first;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoad.first;

    final List<int> imageBytes = List<int>.from(reader.result as List<int>);

    final newPhoto = Photo(
      imageBytes: Uint8List.fromList(imageBytes),
      description: photoDescriptionController.text,
    );

    await _repository.uploadPhoto(newPhoto);
    photos.add(newPhoto);
    photoDescriptionController.clear();
  }
}

// UI
class AdminDataBasePage extends StatelessWidget {
  final controller = Get.put(TasksController());

  AdminDataBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks and Photos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              controller: controller.taskTitleController,
              decoration: InputDecoration(hintText: 'Task Title'),
            ),
            TextField(
              controller: controller.taskDescriptionController,
              decoration: InputDecoration(hintText: 'Task Description'),
            ),
            ElevatedButton(
              onPressed: controller.addTask,
              child: Text('Add Task'),
            ),
            SizedBox(height: 20),
            Text('Tasks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Obx(() => Column(
                  children: controller.tasks
                      .map((task) => ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                            trailing: Checkbox(
                              value: task.isCompleted,
                              onChanged: (bool? value) {
                                // Implement task completion logic here
                              },
                            ),
                          ))
                      .toList(),
                )),
            SizedBox(height: 20),
            Text('Add Photo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              controller: controller.photoDescriptionController,
              decoration: InputDecoration(hintText: 'Photo Description'),
            ),
            ElevatedButton(
              onPressed: controller.pickAndUploadPhoto,
              child: Text('Pick and Upload Photo'),
            ),
            SizedBox(height: 20),
            Text('Photos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Obx(() => Column(
                  children: controller.photos
                      .map((photo) => Column(
                            children: [
                              Image.memory(photo.imageBytes, height: 100),
                              Text(photo.description),
                              Divider(),
                            ],
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}
