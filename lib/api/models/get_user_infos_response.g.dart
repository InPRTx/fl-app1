// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_infos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserInfosResponse _$GetUserInfosResponseFromJson(
  Map<String, dynamic> json,
) => GetUserInfosResponse(
  result: (json['result'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, UserInfo.fromJson(e as Map<String, dynamic>)),
  ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetUserInfosResponseToJson(
  GetUserInfosResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
