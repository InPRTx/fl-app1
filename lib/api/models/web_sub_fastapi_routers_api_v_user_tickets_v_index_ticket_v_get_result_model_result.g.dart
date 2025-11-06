// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_tickets_v_index_ticket_v_get_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult
_$WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult(
  totalCount: (json['total_count'] as num).toInt(),
  tickets: (json['tickets'] as List<dynamic>)
      .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResultToJson(
  WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'tickets': instance.tickets,
};
