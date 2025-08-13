import '../../data/models/todo_model.dart';

abstract class TodoRepository {
  Future<Todo> getTodo(int id);
  Future<Todo> getTodoWithError();
}