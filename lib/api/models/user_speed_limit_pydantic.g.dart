// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_speed_limit_pydantic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSpeedLimitPydantic _$UserSpeedLimitPydanticFromJson(
  Map<String, dynamic> json,
) => UserSpeedLimitPydantic(
  userId: (json['user_id'] as num).toInt(),
  startAt: DateTime.parse(json['start_at'] as String),
  endAt: DateTime.parse(json['end_at'] as String),
  speedLimitMbps: json['speed_limit_mbps'],
  reason: json['reason'] as String? ?? '',
  remark: json['remark'] as String? ?? '',
);

Map<String, dynamic> _$UserSpeedLimitPydanticToJson(
  UserSpeedLimitPydantic instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'start_at': instance.startAt.toIso8601String(),
  'end_at': instance.endAt.toIso8601String(),
  'speed_limit_mbps': instance.speedLimitMbps,
  'reason': instance.reason,
  'remark': instance.remark,
};
