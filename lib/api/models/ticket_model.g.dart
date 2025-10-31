// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  title: json['title'] as String,
  content: json['content'] as String,
  ticketStatus: $enumDecode(_$TicketStatusEnumMap, json['ticket_status']),
  messageData:
      (json['message_data'] as List<dynamic>?)
          ?.map(
            (e) => TicketMessageDataModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'title': instance.title,
      'content': instance.content,
      'ticket_status': _$TicketStatusEnumMap[instance.ticketStatus]!,
      'message_data': instance.messageData,
    };

const _$TicketStatusEnumMap = {
  TicketStatus.pending: 'pending',
  TicketStatus.processing: 'processing',
  TicketStatus.resolved: 'resolved',
  TicketStatus.closed: 'closed',
};
