// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'ticket_v_post_params_model.g.dart';

@JsonSerializable()
class TicketVPostParamsModel {
  const TicketVPostParamsModel({required this.title, required this.content});

  factory TicketVPostParamsModel.fromJson(Map<String, Object?> json) =>
      _$TicketVPostParamsModelFromJson(json);

  /// 工单标题
  final String title;

  /// 工单内容
  final String content;

  Map<String, Object?> toJson() => _$TicketVPostParamsModelToJson(this);
}
