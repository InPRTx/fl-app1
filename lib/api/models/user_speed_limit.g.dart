// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_speed_limit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSpeedLimit _$UserSpeedLimitFromJson(Map<String, dynamic> json) =>
    UserSpeedLimit(
      userId: (json['user_id'] as num).toInt(),
      speedLimitMbps: json['speed_limit_mbps'] as String,
      reason: json['reason'] as String? ?? '',
      remark: json['remark'] as String? ?? '',
      isEmailStartSent: json['is_email_start_sent'] as bool? ?? false,
      isEmailEndSent: json['is_email_end_sent'] as bool? ?? false,
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      startAt: json['start_at'] == null
          ? null
          : DateTime.parse(json['start_at'] as String),
      endAt: json['end_at'] == null
          ? null
          : DateTime.parse(json['end_at'] as String),
    );

Map<String, dynamic> _$UserSpeedLimitToJson(UserSpeedLimit instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'user_id': instance.userId,
      'start_at': ?instance.startAt?.toIso8601String(),
      'end_at': ?instance.endAt?.toIso8601String(),
      'speed_limit_mbps': instance.speedLimitMbps,
      'reason': instance.reason,
      'remark': instance.remark,
      'is_email_start_sent': instance.isEmailStartSent,
      'is_email_end_sent': instance.isEmailEndSent,
    };
