// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_tickets_v_index_ticket_v_get_result_model_result.dart';

part 'ticket_v_get_result_model.g.dart';

@JsonSerializable()
class TicketVGetResultModel {
  const TicketVGetResultModel({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory TicketVGetResultModel.fromJson(Map<String, Object?> json) =>
      _$TicketVGetResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 工单列表信息
  final WebSubFastapiRoutersApiVUserTicketsVIndexTicketVGetResultModelResult
  result;

  Map<String, Object?> toJson() => _$TicketVGetResultModelToJson(this);
}
