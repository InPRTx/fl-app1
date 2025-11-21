// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_old_service_shop_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOldServiceShopListResponse _$GetOldServiceShopListResponseFromJson(
  Map<String, dynamic> json,
) => GetOldServiceShopListResponse(
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
  resultList:
      (json['result_list'] as List<dynamic>?)
          ?.map((e) => OldServiceShopOutput.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GetOldServiceShopListResponseToJson(
  GetOldServiceShopListResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
