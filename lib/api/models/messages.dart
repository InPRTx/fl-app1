// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

@JsonSerializable()
class Messages {
  const Messages({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.ticketId,
    required this.userId,
    required this.content,
  });

  factory Messages.fromJson(Map<String, Object?> json) =>
      _$MessagesFromJson(json);

  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'ticket_id')
  final int ticketId;
  @JsonKey(name: 'user_id')
  final int userId;
  final String content;

  Map<String, Object?> toJson() => _$MessagesToJson(this);
}
