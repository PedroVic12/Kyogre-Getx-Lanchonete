import 'package:dio/dio.dart';

class FirebaseApiService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://groundon-citta-cardapio-default-rtdb.firebaseio.com';

  FirebaseApiService() {
    _dio.options.headers['Access-Control-Allow-Origin'] = '*';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<String> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await _dio.post('$_baseUrl/tasks.json', data: taskData);
      if (response.statusCode == 200) {
        return response.data['name']; // Firebase returns the new task ID
      } else {
        throw Exception('Failed to create task: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error creating task: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final response = await _dio.get('$_baseUrl/tasks.json');
      if (response.statusCode == 200) {
        final dynamic data = response.data;
        if (data == null) return [];
        if (data is Map<String, dynamic>) {
          return data.entries
              .map((entry) =>
                  {'id': entry.key, ...entry.value as Map<String, dynamic>})
              .toList();
        } else if (data is List) {
          return data.cast<Map<String, dynamic>>();
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to get tasks: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error getting tasks: ${e.message}');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('$_baseUrl/categories.json');
      if (response.statusCode == 200) {
        final dynamic data = response.data;
        if (data == null) return [];
        if (data is List) {
          return data.cast<String>();
        } else if (data is Map) {
          return data.values.cast<String>().toList();
        } else {
          throw Exception('Unexpected data format for categories');
        }
      } else {
        throw Exception('Failed to get categories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error getting categories: ${e.message}');
    }
  }
}
