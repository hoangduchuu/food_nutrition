import 'package:dio/dio.dart';
import '../models/todo_model.dart';

class TodoApi {
  final Dio _dio;

  TodoApi(this._dio);

  Future<Todo> getTodo(int id) async {
    final response = await _dio.get('/todos/$id');
    return Todo.fromJson(response.data);
  }

  Future<Todo> getTodoWithError() async {
    final response = await _dio.get('/todos/999999');
    return Todo.fromJson(response.data);
  }
}