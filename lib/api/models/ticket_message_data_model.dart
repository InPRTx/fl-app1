// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'ticket_message_data_model.g.dart';

@JsonSerializable()
class TicketMessageDataModel {
  const TicketMessageDataModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.content,
  });

  factory TicketMessageDataModel.fromJson(Map<String, Object?> json) =>
      _$TicketMessageDataModelFromJson(json);

  final String id;

  /// 创建时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 更新时间
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 消息内容
  final String content;

  Map<String, Object?> toJson() => _$TicketMessageDataModelToJson(this);
}
