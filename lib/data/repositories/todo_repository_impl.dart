import '../../domain/repositories/todo_repository.dart';
import '../models/todo_model.dart';
import '../api/todo_api.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoApi _todoApi;

  TodoRepositoryImpl(this._todoApi);

  @override
  Future<Todo> getTodo(int id) async {
    return await _todoApi.getTodo(id);
  }

  @override
  Future<Todo> getTodoWithError() async {
    return await _todoApi.getTodoWithError();
  }
}