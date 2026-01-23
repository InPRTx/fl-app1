// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_old_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserOldServiceResponse _$GetUserOldServiceResponseFromJson(
  Map<String, dynamic> json,
) => GetUserOldServiceResponse(
  result: json['result'] == null
      ? null
      : AdminOldServiceOutput.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetUserOldServiceResponseToJson(
  GetUserOldServiceResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
