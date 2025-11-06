// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_invite_index_user_invite_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult
_$WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult(
  inviteCode: json['invite_code'] as String,
  inviteLink: json['invite_link'] as String,
  totalInvites: (json['total_invites'] as num).toInt(),
  totalCommission: json['total_commission'] as String,
  commissionRate: json['commission_rate'] as String,
  invitedUsers: (json['invited_users'] as List<dynamic>)
      .map((e) => InvitedUser.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResultToJson(
  WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult instance,
) => <String, dynamic>{
  'invite_code': instance.inviteCode,
  'invite_link': instance.inviteLink,
  'total_invites': instance.totalInvites,
  'total_commission': instance.totalCommission,
  'commission_rate': instance.commissionRate,
  'invited_users': instance.invitedUsers,
};
