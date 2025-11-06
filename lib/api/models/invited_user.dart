// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'invited_user.g.dart';

@JsonSerializable()
class InvitedUser {
  const InvitedUser({
    required this.userId,
    required this.username,
    required this.registeredAt,
    required this.commissionEarned,
    required this.status,
  });

  factory InvitedUser.fromJson(Map<String, Object?> json) =>
      _$InvitedUserFromJson(json);

  /// 被邀请用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 被邀请用户名
  final String username;

  /// 注册时间
  @JsonKey(name: 'registered_at')
  final DateTime registeredAt;

  /// 获得佣金
  @JsonKey(name: 'commission_earned')
  final String commissionEarned;

  /// 用户状态
  final String status;

  Map<String, Object?> toJson() => _$InvitedUserToJson(this);
}
