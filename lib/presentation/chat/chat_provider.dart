import 'package:flutter/foundation.dart';
import 'package:food_nutrition/data/models/chat_message.dart';
import 'package:food_nutrition/data/models/chat_user.dart';
import 'package:food_nutrition/domain/repositories/chat_repository.dart';
import 'package:food_nutrition/core/di/injection_container.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepository _chatRepository = getIt<ChatRepository>();
  
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;
  bool _isConnected = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isConnected => _isConnected;

  ChatUser get currentUser => const ChatUser(
    id: 'user-1',
    name: 'User',
    role: UserRole.user,
  );

  ChatUser get adminUser => const ChatUser(
    id: 'admin-1',
    name: 'Admin',
    role: UserRole.admin,
  );

  Future<void> connect() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _chatRepository.connect();
      _isConnected = true;

      _chatRepository.getMessages().listen((messages) {
        _messages = messages;
        notifyListeners();
      });

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      _isConnected = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String content, {bool asAdmin = false}) async {
    try {
      if (!_isConnected) {
        await connect();
      }

      final sender = asAdmin ? adminUser : currentUser;
      await _chatRepository.sendMessage(content, sender);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> disconnect() async {
    try {
      await _chatRepository.disconnect();
      _isConnected = false;
      _messages = [];
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}