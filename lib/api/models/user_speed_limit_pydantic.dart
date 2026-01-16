// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_speed_limit_pydantic.g.dart';

/// 用户限速/封禁记录 Pydantic 模型
@JsonSerializable()
class UserSpeedLimitPydantic {
  const UserSpeedLimitPydantic({
    required this.userId,
    required this.startAt,
    required this.endAt,
    required this.speedLimitMbps,
    this.reason = '',
    this.remark = '',
  });

  factory UserSpeedLimitPydantic.fromJson(Map<String, Object?> json) =>
      _$UserSpeedLimitPydanticFromJson(json);

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 限速开始时间
  @JsonKey(name: 'start_at')
  final DateTime startAt;

  /// 限速结束时间
  @JsonKey(name: 'end_at')
  final DateTime endAt;

  /// 速度限制 (Mbps)，0 表示完全封禁
  @JsonKey(name: 'speed_limit_mbps')
  final dynamic speedLimitMbps;

  /// 限速原因
  final String reason;

  /// 备注信息
  final String remark;

  Map<String, Object?> toJson() => _$UserSpeedLimitPydanticToJson(this);
}
