import 'package:json_annotation/json_annotation.dart';

part 'chat_user.g.dart';

enum UserRole { admin, user }

@JsonSerializable()
class ChatUser {
  final String id;
  final String name;
  final UserRole role;

  const ChatUser({
    required this.id,
    required this.name,
    required this.role,
  });

  bool get isAdmin => role == UserRole.admin;

  factory ChatUser.fromJson(Map<String, dynamic> json) => _$ChatUserFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}