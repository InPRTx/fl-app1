// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_old_shop_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceOldShopResult _$GetServiceOldShopResultFromJson(
  Map<String, dynamic> json,
) => GetServiceOldShopResult(
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
  resultList:
      (json['result_list'] as List<dynamic>?)
          ?.map((e) => OldServiceShop.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GetServiceOldShopResultToJson(
  GetServiceOldShopResult instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
