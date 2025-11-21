// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ticket_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTicketView _$UserTicketViewFromJson(Map<String, dynamic> json) =>
    UserTicketView(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userId: (json['user_id'] as num).toInt(),
      title: json['title'] as String,
      ticketStatus: $enumDecode(
        _$TicketStatusEnumEnumMap,
        json['ticket_status'],
      ),
      isMarkdown: json['is_markdown'] as bool,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
      userIds: (json['user_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$UserTicketViewToJson(UserTicketView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user_id': instance.userId,
      'title': instance.title,
      'ticket_status': _$TicketStatusEnumEnumMap[instance.ticketStatus]!,
      'is_markdown': instance.isMarkdown,
      'messages': ?instance.messages,
      'user_ids': ?instance.userIds,
    };

const _$TicketStatusEnumEnumMap = {
  TicketStatusEnum.pending: 'pending',
  TicketStatusEnum.processing: 'processing',
  TicketStatusEnum.resolved: 'resolved',
  TicketStatusEnum.closed: 'closed',
};
