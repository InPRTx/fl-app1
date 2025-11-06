// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invited_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitedUser _$InvitedUserFromJson(Map<String, dynamic> json) => InvitedUser(
  userId: (json['user_id'] as num).toInt(),
  username: json['username'] as String,
  registeredAt: DateTime.parse(json['registered_at'] as String),
  commissionEarned: json['commission_earned'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$InvitedUserToJson(InvitedUser instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'registered_at': instance.registeredAt.toIso8601String(),
      'commission_earned': instance.commissionEarned,
      'status': instance.status,
    };
