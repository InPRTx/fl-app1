// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ticket_status_enum.dart';

part 'reply_params.g.dart';

@JsonSerializable()
class ReplyParams {
  const ReplyParams({required this.content, this.status});

  factory ReplyParams.fromJson(Map<String, Object?> json) =>
      _$ReplyParamsFromJson(json);

  /// 回复内容
  final String content;

  /// 可选，变更工单状态
  @JsonKey(includeIfNull: false)
  final TicketStatusEnum? status;

  Map<String, Object?> toJson() => _$ReplyParamsToJson(this);
}
