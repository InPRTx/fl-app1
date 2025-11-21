// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_old_service_shop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOldServiceShopResponse _$GetOldServiceShopResponseFromJson(
  Map<String, dynamic> json,
) => GetOldServiceShopResponse(
  result: json['result'] == null
      ? null
      : OldServiceShopOutput.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$GetOldServiceShopResponseToJson(
  GetOldServiceShopResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
