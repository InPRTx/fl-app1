// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyParams _$ReplyParamsFromJson(Map<String, dynamic> json) => ReplyParams(
  content: json['content'] as String,
  status: $enumDecodeNullable(_$TicketStatusEnumEnumMap, json['status']),
);

Map<String, dynamic> _$ReplyParamsToJson(ReplyParams instance) =>
    <String, dynamic>{
      'content': instance.content,
      'status': ?_$TicketStatusEnumEnumMap[instance.status],
    };

const _$TicketStatusEnumEnumMap = {
  TicketStatusEnum.pending: 'pending',
  TicketStatusEnum.processing: 'processing',
  TicketStatusEnum.resolved: 'resolved',
  TicketStatusEnum.closed: 'closed',
};
