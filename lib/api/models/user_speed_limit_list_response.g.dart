// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_speed_limit_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSpeedLimitListResponse _$UserSpeedLimitListResponseFromJson(
  Map<String, dynamic> json,
) => UserSpeedLimitListResponse(
  result: (json['result'] as List<dynamic>?)
      ?.map((e) => UserSpeedLimit.fromJson(e as Map<String, dynamic>))
      .toList(),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UserSpeedLimitListResponseToJson(
  UserSpeedLimitListResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
  'total': instance.total,
};
