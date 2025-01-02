import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api_app/constants/enum.dart';
import 'package:rest_api_app/models/todo.dart';

class SubmitResult {
  final SubmitStatus status;
  final String message;

  SubmitResult(this.status, this.message);
}

class TodoApi {
  static Future<List<Todo>> getApi() async {
    int currentPage = 1;
    List<Todo> allTodos = [];
    bool hasNextPage = true;
    while (hasNextPage) {
      final String url =
          'https://api.nstack.in/v1/todos?page=$currentPage&limit=3';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final int totalPages = json['meta']['total_pages'];
        final res = json['items'] as List<dynamic>;
        final todos = res.map((e) => Todo.fromJson(e)).toList();
        allTodos.addAll(todos);
        // Kiểm tra nếu còn trang tiếp theo
        if (currentPage < totalPages) {
          currentPage++; // Tăng page để tải tiếp
        } else {
          hasNextPage = false; // Nếu không còn trang nào, dừng vòng lặp
        }
      } else {
        throw Exception('Failed to load data');
      }
    }
    return allTodos;
  }

  static Future<bool> deleteApiById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<bool> postApi({String? title, String? description}) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 201;
  }

  static Future<bool> putApi({Todo? todo}) async {
    final body = {
      "title": todo!.title,
      "description": todo.description,
      "is_completed": todo.isCompleted
    };
    final id = todo.sId;
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }
}
