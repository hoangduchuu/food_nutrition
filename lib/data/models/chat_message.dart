import 'package:json_annotation/json_annotation.dart';
import 'chat_user.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  final String id;
  final String content;
  final ChatUser sender;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}