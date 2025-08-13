import 'package:food_nutrition/data/models/chat_message.dart';
import 'package:food_nutrition/data/models/chat_user.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> getMessages();
  Future<void> sendMessage(String content, ChatUser sender);
  Future<void> connect();
  Future<void> disconnect();
}