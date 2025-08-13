import 'dart:async';
import 'package:food_nutrition/data/models/chat_message.dart';
import 'package:food_nutrition/data/models/chat_user.dart';
import 'package:food_nutrition/domain/repositories/chat_repository.dart';

class WebSocketChatRepositoryImpl implements ChatRepository {
  final StreamController<List<ChatMessage>> _messagesController = StreamController<List<ChatMessage>>.broadcast();
  final List<ChatMessage> _messages = [];

  @override
  Stream<List<ChatMessage>> getMessages() {
    return _messagesController.stream;
  }

  @override
  Future<void> connect() async {
    // For demo purposes, simulate a successful connection
    // In a real implementation, this would connect to a WebSocket server
    await Future.delayed(Duration(milliseconds: 100));
  }

  @override
  Future<void> sendMessage(String content, ChatUser sender) async {
    try {
      final message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        sender: sender,
        timestamp: DateTime.now(),
      );

      // Add message to local list immediately (optimistic update)
      _messages.add(message);
      _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      _messagesController.add(List.from(_messages));

      // In a real implementation, this would send to a WebSocket server
      // For now, simulate sending to demonstrate local functionality
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  Future<void> disconnect() async {
    try {
      await _messagesController.close();
    } catch (e) {
      throw Exception('Failed to disconnect from chat: $e');
    }
  }
}