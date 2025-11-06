// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ticket_message_data_model.dart';
import 'ticket_status.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  const TicketModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.content,
    required this.ticketStatus,
    this.messageData = const [],
  });

  factory TicketModel.fromJson(Map<String, Object?> json) =>
      _$TicketModelFromJson(json);

  /// 工单ID
  final String id;

  /// 创建时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 更新时间
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// 工单标题
  final String title;

  /// 工单内容
  final String content;

  /// 工单状态
  @JsonKey(name: 'ticket_status')
  final TicketStatus ticketStatus;

  /// 工单消息列表
  @JsonKey(name: 'message_data')
  final List<TicketMessageDataModel> messageData;

  Map<String, Object?> toJson() => _$TicketModelToJson(this);
}
