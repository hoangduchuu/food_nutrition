import 'package:flutter/material.dart';
import '../../data/models/todo_model.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../utils/loading_utils.dart';

class HomeProvider extends ChangeNotifier {
  final TodoRepository _todoRepository;

  HomeProvider(this._todoRepository);

  Todo? _currentTodo;
  bool _isLoading = false;

  Todo? get currentTodo => _currentTodo;
  bool get isLoading => _isLoading;

  Future<void> testSuccessCall() async {
    try {
      _setLoading(true);
      
      LoadingUtils.showProgress(message: 'Loading...');
      
      await Future.delayed(const Duration(seconds: 2));
      
      final todo = await _todoRepository.getTodo(1);
      _currentTodo = todo;
      
      LoadingUtils.showSuccessMessage('Todo loaded successfully!');
    } catch (e) {
      LoadingUtils.showErrorMessage('Failed to load todo');
    } finally {
      _setLoading(false);
      LoadingUtils.dismiss();
    }
  }

  Future<void> testErrorCall() async {
    try {
      _setLoading(true);
      
      LoadingUtils.showProgress(message: 'Loading...');
      
      await Future.delayed(const Duration(seconds: 2));
      
      await _todoRepository.getTodoWithError();
    } catch (e) {
      LoadingUtils.showErrorMessage('Request failed!');
    } finally {
      _setLoading(false);
      LoadingUtils.dismiss();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}