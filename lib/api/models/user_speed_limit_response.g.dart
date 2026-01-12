// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_speed_limit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSpeedLimitResponse _$UserSpeedLimitResponseFromJson(
  Map<String, dynamic> json,
) => UserSpeedLimitResponse(
  result: json['result'] == null
      ? null
      : UserSpeedLimit.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '操作成功',
);

Map<String, dynamic> _$UserSpeedLimitResponseToJson(
  UserSpeedLimitResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
