// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
  id: (json['id'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  ticketId: (json['ticket_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  content: json['content'] as String,
);

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'ticket_id': instance.ticketId,
  'user_id': instance.userId,
  'content': instance.content,
};
