// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_message_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketMessageDataModel _$TicketMessageDataModelFromJson(
  Map<String, dynamic> json,
) => TicketMessageDataModel(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  userId: (json['user_id'] as num).toInt(),
  content: json['content'] as String,
);

Map<String, dynamic> _$TicketMessageDataModelToJson(
  TicketMessageDataModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'user_id': instance.userId,
  'content': instance.content,
};
