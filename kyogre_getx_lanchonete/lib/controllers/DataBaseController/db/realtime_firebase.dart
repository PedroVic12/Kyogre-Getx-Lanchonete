import 'package:dio/dio.dart';

class FirebaseApiService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://groundon-citta-cardapio-default-rtdb.firebaseio.com';

  Future<String> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await _dio.post('$_baseUrl/tasks.json', data: taskData);
      if (response.statusCode == 200) {
        return response.data['name']; // Firebase returns the new task ID
      } else {
        throw Exception('Failed to create task');
      }
    } catch (e) {
      throw Exception('Error creating task: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final response = await _dio.get('$_baseUrl/tasks.json');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return data.entries
            .map((entry) =>
                {'id': entry.key, ...entry.value as Map<String, dynamic>})
            .toList();
      } else {
        throw Exception('Failed to get tasks');
      }
    } catch (e) {
      throw Exception('Error getting tasks: $e');
    }
  }
}
