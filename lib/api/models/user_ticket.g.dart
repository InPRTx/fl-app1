// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTicket _$UserTicketFromJson(Map<String, dynamic> json) => UserTicket(
  title: json['title'] as String,
  ticketStatus:
      $enumDecodeNullable(_$TicketStatusEnumEnumMap, json['ticket_status']) ??
      TicketStatusEnum.pending,
  isMarkdown: json['is_markdown'] as bool? ?? true,
  id: (json['id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  userId: (json['user_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserTicketToJson(UserTicket instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'user_id': ?instance.userId,
      'title': instance.title,
      'ticket_status': _$TicketStatusEnumEnumMap[instance.ticketStatus]!,
      'is_markdown': instance.isMarkdown,
    };

const _$TicketStatusEnumEnumMap = {
  TicketStatusEnum.pending: 'pending',
  TicketStatusEnum.processing: 'processing',
  TicketStatusEnum.resolved: 'resolved',
  TicketStatusEnum.closed: 'closed',
};
