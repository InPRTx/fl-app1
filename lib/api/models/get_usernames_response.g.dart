// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_usernames_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUsernamesResponse _$GetUsernamesResponseFromJson(
  Map<String, dynamic> json,
) => GetUsernamesResponse(
  result: (json['result'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetUsernamesResponseToJson(
  GetUsernamesResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
