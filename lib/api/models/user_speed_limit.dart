// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_speed_limit.g.dart';

/// 用户限速/封禁记录表.
///
/// 使用动态时间判断方式，通过排他约束确保同一用户的限速时间段不重叠。.
/// 不使用 is_task_begin/is_task_finish 字段，而是通过实时查询 start_at 和 end_at 判断状态。.
///
/// 查询用户当前限速状态示例：.
///     SELECT speed_limit_mbps FROM user_speed_limit_raw.
///     WHERE user_id = ? AND start_at <= NOW() AND end_at > NOW().
///     ORDER BY start_at DESC LIMIT 1.
@JsonSerializable()
class UserSpeedLimit {
  const UserSpeedLimit({
    required this.userId,
    required this.speedLimitMbps,
    this.reason = '',
    this.remark = '',
    this.isEmailStartSent = false,
    this.isEmailEndSent = false,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.startAt,
    this.endAt,
  });

  factory UserSpeedLimit.fromJson(Map<String, Object?> json) =>
      _$UserSpeedLimitFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false, name: 'updated_at')
  final DateTime? updatedAt;

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 限速开始时间
  @JsonKey(includeIfNull: false, name: 'start_at')
  final DateTime? startAt;

  /// 限速结束时间
  @JsonKey(includeIfNull: false, name: 'end_at')
  final DateTime? endAt;

  /// 速度限制 (Mbps)，必须大于 0
  @JsonKey(name: 'speed_limit_mbps')
  final String speedLimitMbps;

  /// 限速原因
  final String reason;

  /// 备注信息
  final String remark;

  /// 是否已发送开始通知邮件（可选功能，默认不发送）
  @JsonKey(name: 'is_email_start_sent')
  final bool isEmailStartSent;

  /// 是否已发送结束通知邮件（可选功能，默认不发送）
  @JsonKey(name: 'is_email_end_sent')
  final bool isEmailEndSent;

  Map<String, Object?> toJson() => _$UserSpeedLimitToJson(this);
}
