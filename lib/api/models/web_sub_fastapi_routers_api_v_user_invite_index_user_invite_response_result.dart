// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'invited_user.dart';

part 'web_sub_fastapi_routers_api_v_user_invite_index_user_invite_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult {
  const WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult({
    required this.inviteCode,
    required this.inviteLink,
    required this.totalInvites,
    required this.totalCommission,
    required this.commissionRate,
    required this.invitedUsers,
  });

  factory WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResultFromJson(
        json,
      );

  /// 邀请码
  @JsonKey(name: 'invite_code')
  final String inviteCode;

  /// 邀请链接
  @JsonKey(name: 'invite_link')
  final String inviteLink;

  /// 总邀请人数
  @JsonKey(name: 'total_invites')
  final int totalInvites;

  /// 总佣金收入
  @JsonKey(name: 'total_commission')
  final String totalCommission;

  /// 佣金比例
  @JsonKey(name: 'commission_rate')
  final String commissionRate;

  /// 被邀请用户列表
  @JsonKey(name: 'invited_users')
  final List<InvitedUser> invitedUsers;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResultToJson(
        this,
      );
}
