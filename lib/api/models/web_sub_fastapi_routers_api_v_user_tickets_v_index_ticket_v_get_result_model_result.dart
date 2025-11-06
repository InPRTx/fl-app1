// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ticket_model.dart';

part 'web_sub_fastapi_routers_api_v_user_tickets_v_index_ticket_v_get_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult {
  const WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult({
    required this.totalCount,
    required this.tickets,
  });

  factory WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResultFromJson(
        json,
      );

  /// 工单总数
  @JsonKey(name: 'total_count')
  final int totalCount;

  /// 工单列表
  final List<TicketModel> tickets;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResultToJson(
        this,
      );
}
